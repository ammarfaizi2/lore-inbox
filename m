Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268396AbUILB4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268396AbUILB4q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 21:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268400AbUILB4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 21:56:46 -0400
Received: from web11901.mail.yahoo.com ([216.136.172.185]:16401 "HELO
	web11901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268396AbUILBz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 21:55:59 -0400
Message-ID: <20040912015559.73765.qmail@web11901.mail.yahoo.com>
Date: Sat, 11 Sep 2004 18:55:59 -0700 (PDT)
From: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: radeon-pre-2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Vladimir Dergachev <volodya@mindspring.com>
Cc: Michel =?ISO-8859-1?Q?=20=22D=E4nzer=22?= <michel@daenzer.net>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?=20=22K=FChling=22?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1094915671.21290.77.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sad, 2004-09-11 at 16:53, Vladimir Dergachev wrote:
> >      Lastly, I am not saying you have to put all the code in the same
> file.
> > All I am saying we can mandate that all Radeon HW specific code is
> linked
> > in one module - and this would make things easier for developers.
> 
> And if I want dri but not frame buffer, or vice versa, as the majority
> of current users do 
> 
Hopefully any change to the kernel will allow building FB without DRM. 
This is a trivial seperation of code, that I might add has allready been
done, a good point that we should keep it this way.  Yes, there will be
some new memory mngmt code, posibly optonal as well, that is needed for
multi-headed setups.

> >      I would agree that this can be coded as well - but why bother ?
> Or is 
> > it done and working already ?
> 
> Splitting the modules up is the easy bit. The API is the hard bit so you
> might as well formalize it. It also gives the users the ability to not
> load huge radeon modules.
> 
> 
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



		
_______________________________
Do you Yahoo!?
Express yourself with Y! Messenger! Free. Download now. 
http://messenger.yahoo.com
