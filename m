Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312256AbSC2WuW>; Fri, 29 Mar 2002 17:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312261AbSC2WuB>; Fri, 29 Mar 2002 17:50:01 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:1275 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312256AbSC2Wt4>;
	Fri, 29 Mar 2002 17:49:56 -0500
Date: Fri, 29 Mar 2002 14:49:07 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>, gerrit@us.ibm.com
Subject: Re: Backport of Ingo/Arjan highpte to 2.4.18 (+O1 scheduler)
Message-ID: <13110000.1017442147@flay>
In-Reply-To: <20020326180841.C13052@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not considering to drop pte-highmem from 2.4 and to only support the
> user-fixmaps in 2.5 because it is a showstopper bugfix for lots of
> important users that definitely cannot wait 2.6. I'm also not
> considering backporting the user-fixmaps because that would be a quite
> invasive change messing also with the alignment of the user stack (I
> know it could stay into kernel space, but right after the user stack it
> will be more optimized and cleaner/simpler, so I prefer to put the few
> virtual pages there).

Can you explain the problem with the aligment of the user stack? I can't
see what the problem is here .... and we need to start thinking about how
to fix it if you've seen a problem that we haven't ....

Thanks,

M.


