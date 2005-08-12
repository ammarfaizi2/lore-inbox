Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbVHLVyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVHLVyQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 17:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVHLVyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 17:54:15 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:21182 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751293AbVHLVyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 17:54:15 -0400
Subject: Re: [PATCH] Fix PPC signal handling of NODEFER, should not affect
	sa_mask
From: Steven Rostedt <rostedt@goodmis.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Chris Wright <chrisw@osdl.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
In-Reply-To: <9a87484905081212317ca8c04e@mail.gmail.com>
References: <1123615983.18332.194.camel@localhost.localdomain>
	 <1123618745.18332.204.camel@localhost.localdomain>
	 <20050809204928.GH7991@shell0.pdx.osdl.net>
	 <1123621223.9553.4.camel@localhost.localdomain>
	 <1123621637.9553.7.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508091419420.3258@g5.osdl.org>
	 <1123643401.9553.32.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0508122036500.16845@yvahk01.tjqt.qr>
	 <20050812184503.GX7762@shell0.pdx.osdl.net>
	 <Pine.LNX.4.58.0508121456570.19908@localhost.localdomain>
	 <9a87484905081212317ca8c04e@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 12 Aug 2005 17:53:53 -0400
Message-Id: <1123883633.5296.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two more systems that are different from Linux.

So far, Linux is the odd ball out.

-- Steve


On Fri, 2005-08-12 at 22:28 +0100, someone else wrote: 
> 
> SunOS hostname 5.10 Generic sun4u sparc SUNW,Sun-Blade-1000
> 
> sa_mask blocks other signals
> SA_NODEFER does not block other signals
> SA_NODEFER does not affect sa_mask
> SA_NODEFER and sa_mask blocks sig
> !SA_NODEFER blocks sig
> SA_NODEFER does not block sig
> sa_mask blocks sig
> 
> 
> OSF1 hostname V5.1 2650 alpha
> 
> sa_mask blocks other signals
> SA_NODEFER does not block other signals
> SA_NODEFER does not affect sa_mask
> SA_NODEFER and sa_mask blocks sig
> !SA_NODEFER blocks sig
> SA_NODEFER does not block sig
> sa_mask blocks sig
> 
> 

