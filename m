Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267967AbTBYT2z>; Tue, 25 Feb 2003 14:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268032AbTBYT2y>; Tue, 25 Feb 2003 14:28:54 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:48358 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267967AbTBYT2y>; Tue, 25 Feb 2003 14:28:54 -0500
Date: Tue, 25 Feb 2003 11:29:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Manfred Spraul <manfred@colorfullife.com>, Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: Horrible L2 cache effects from kernel compile
Message-ID: <376650000.1046201398@flay>
In-Reply-To: <3E5BB7EE.5090301@colorfullife.com>
References: <3E5BB7EE.5090301@colorfullife.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Btw, has anyone tried to replaced the global dcache with something local,
> perhaps a tree instead of d_child, and then lookup in d_child_tree?

I don't think anyone does this, but I've been considering doing this for
over a year now ... I just feel there's bound to be some inherent problem,
or someone would have done it already. But there's only one real way to
find that out ;-)

