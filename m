Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132620AbRDOKkH>; Sun, 15 Apr 2001 06:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132622AbRDOKj5>; Sun, 15 Apr 2001 06:39:57 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:731 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132620AbRDOKjo>; Sun, 15 Apr 2001 06:39:44 -0400
Message-Id: <5.0.2.1.2.20010415112829.00b11ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sun, 15 Apr 2001 11:41:36 +0100
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: CML2 1.1.1, wiuth experimental fast mode
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200104150345.f3F3jxG16241@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:45 15/04/2001, Eric S. Raymond wrote:
>Release 1.1.1: Sat Apr 14 23:41:34 EDT 2001
>         * The old menuconfig shortcut that 'm' in a boolean entry field
>           sets 'y' is now implemented.
>         * Simplified color scheme.

Much better now! make xconfig still seems to be the old way (hadn't tried 
it before)? - At least I get two shades of green. The lighter one is 
completely unreadable on the silver background. Could I suggest to get rid 
of the light/dark green distinction altogether, do it like the new 
menuconfig colors, they are much improved now. - Also removing the N and 
replacing M by m has improved readability  by a long way. (-:

>         * Added fast-mode command to suppress side-effect computation
>           on slow machines.
>
>I'd appreciate it if some of you with slow machines would try running
>with fast mode on and seeing if that addresses the sluggishness.

On my Pentium 133S with fastmode I get a more than 2 fold increase in speed 
and  it feels a lot more usable. Still have to wait between key presses but 
it is better than before.

I also tried this on a Dual Celeron 450. Speed is fine but you can still 
feel that something is happening in between the key press and it taking 
effect. fastmode doesn't make much difference that I could feel there.

One general note: scrolling between entries (up/down arrow) seems slower 
than it should be. It is noticeable when you want to scroll several entries 
at once and hit an arrow key quickly several times in succession. Perhaps 
the action taken after reaching an entry could be delayed until the next 
key press and only then when it is not one of the move to next/prev option 
ones? That should make moving up/down instantaneous like in the old (cml1) 
menuconfig. But then I have no idea how cml2 works so maybe my suggestion 
is bogus...

Keep up the good work. You are on the right track. (-:

Best regards,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

