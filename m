Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRDOQDa>; Sun, 15 Apr 2001 12:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132692AbRDOQDV>; Sun, 15 Apr 2001 12:03:21 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:53769 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S129282AbRDOQDN>;
	Sun, 15 Apr 2001 12:03:13 -0400
Date: Sun, 15 Apr 2001 12:04:30 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.1.1, wiuth experimental fast mode
Message-ID: <20010415120430.A29710@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200104150345.f3F3jxG16241@snark.thyrsus.com> <5.0.2.1.2.20010415112829.00b11ec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.2.1.2.20010415112829.00b11ec0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Sun, Apr 15, 2001 at 11:41:36AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk>:
> Much better now! make xconfig still seems to be the old way (hadn't tried 
> it before)? - At least I get two shades of green. The lighter one is 
> completely unreadable on the silver background. Could I suggest to get rid 
> of the light/dark green distinction altogether, do it like the new 
> menuconfig colors, they are much improved now.

Yeah, that was a typo.  It will work this way in 1.1.2.

> On my Pentium 133S with fastmode I get a more than 2 fold increase in speed 
> and  it feels a lot more usable. Still have to wait between key presses but 
> it is better than before.

Uh oh.  

If you still have to wait I'd better make fastmode disable more stuff :-(.
 
> One general note: scrolling between entries (up/down arrow) seems slower 
> than it should be.

That should be fixed now.  I found a way to recode menuconfig's screen refresh
that will be faster and eliminate the screen flicker.

> Keep up the good work. You are on the right track. (-:

Thanks!
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Rightful liberty is unobstructed action, according to our will, within limits
drawn around us by the equal rights of others."
	-- Thomas Jefferson
