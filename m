Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135573AbRDSGlT>; Thu, 19 Apr 2001 02:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135574AbRDSGlK>; Thu, 19 Apr 2001 02:41:10 -0400
Received: from [196.38.105.82] ([196.38.105.82]:38663 "EHLO www.webtrac.co.za")
	by vger.kernel.org with ESMTP id <S135573AbRDSGlH>;
	Thu, 19 Apr 2001 02:41:07 -0400
Date: Thu, 19 Apr 2001 08:40:05 +0200
From: Craig Schlenter <craig@webtelecoms.co.za>
To: Ben Pfaff <pfaffben@msu.edu>
Cc: Jani Monoses <jani@virtualro.ic.ro>, linux-kernel@vger.kernel.org
Subject: Re: Rage Mobility P/M
Message-ID: <20010419084005.B8937@webtelecoms.co.za>
In-Reply-To: <Pine.LNX.4.10.10104182114340.1604-100000@virtualro.ic.ro> <874rvmrraa.fsf@pfaffben.user.msu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <874rvmrraa.fsf@pfaffben.user.msu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 02:34:05PM -0400, Ben Pfaff wrote:
> Jani Monoses <jani@virtualro.ic.ro> writes:
> 
> > 	does the atyfb or aty128fb  support this chip?
> > Device id of 4c4d.
> > Using 2.4.3-ac7.
> 
> I have a Rage Mobility with the same device ID on my laptop
> (Compaq Armada M700) but haven't been able to get it working with
> framebuffer.  At any rate, atyfb is the proper one to use.  Let
> me know if you get it working, I'd like to use it too.

Tried a late model ac kernel and 2.4.4pre3. The ac kernel seems to
have a somewhat re-organised atyfb driver. Both fail dismally - I
see 'flashes' on the screen when typing stuff but the screen is
essentially blank. vesafb worked for the minute or two during which
I tested it but I couldn't get x running on top of the framebuffer
so I've gone back to normal vga console stuff and using a ati X
driver. Interestingly, the atyfb driver reported my card as 'PCI'
instead of AGP. Device ID is 4c4d. Machine is a Dell latitude CPt S600Gt.

I'd be keen to hear if anyone gets it working ... 

--Craig
