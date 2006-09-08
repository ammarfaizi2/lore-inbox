Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWIHPef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWIHPef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 11:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWIHPef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 11:34:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:57552 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750813AbWIHPed
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 11:34:33 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
	memory)
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: balbir@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>, Srivatsa <vatsa@in.ibm.com>
In-Reply-To: <44FEC7E4.7030708@sw.ru>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 08:33:53 -0700
Message-Id: <1157729633.26324.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 17:06 +0400, Kirill Korotaev wrote:
> It was discussed multiple times already.
> The key problem here is the objects which do not _belong_ to tasks. 

Heh.  The original CKRM patches didn't have a strong binding to tasks.
They took it away to make them more mergeable. ;)

-- Dave

