Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268137AbUIKMtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268137AbUIKMtf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 08:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268146AbUIKMtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 08:49:35 -0400
Received: from web11906.mail.yahoo.com ([216.136.172.190]:58375 "HELO
	web11906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268137AbUIKMtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 08:49:32 -0400
Message-ID: <20040911124930.98551.qmail@web11906.mail.yahoo.com>
Date: Sat, 11 Sep 2004 05:49:30 -0700 (PDT)
From: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: radeon-pre-2
To: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>
Cc: Jon Smirl <jonsmirl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?=20=22Felix=5FK=FChling=22?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20040911132727.A1783@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Christoph Hellwig <hch@infradead.org> wrote:

> > If the kernel developers can address this point I would be most
> > interested, in fact I don't want to hear any more about sharing
> lowlevel
> > VGA device drivers until someone addresses why it is acceptable to
> have
> > two separate driver driving the same hardware for video and not for
> > anything else.. (remembering graphics cards are not-multifunction
> cards -
> > like Christoph used as an example before - 2d/3d are not separate
> > functions...)...
> 
> Well, Alan's proposal gets things back into a working shape with both
> fbdev and get additional benefits like hotplug and autloading without
> a major revamp of everything.  The major rework will have to happen
> sooner
> or later anyway, but by fixing the obvious problems we face now first it
> can be done in small pieces and with far less pressure.
> 
Not to step on toes, but...  From what I can tell the idea is to add code
into FB that calles functions in the DRM and vice vers.  This would seam
to  add another ABI.  Unless the code gets linked into one module, this
idea has been flamed and killed already.

I would be willing to bet that if some one did this, into one module, it
would be exepted by all.  However I don't see why we can't add multi-head
support, posibly at the same time? -Since Joe seams so willing to do this,
why not let him.

> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM. 
> Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
