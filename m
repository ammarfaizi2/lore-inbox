Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276312AbRKNSRy>; Wed, 14 Nov 2001 13:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276094AbRKNSRn>; Wed, 14 Nov 2001 13:17:43 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:9013 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S276312AbRKNSRa>; Wed, 14 Nov 2001 13:17:30 -0500
Date: Wed, 14 Nov 2001 13:17:23 -0500
From: <joeja@mindspring.com>
To: Michael Peddemors <michael@wizard.ca>
Cc: John Alvord <jalvo@mbay.net>, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: loop back broken in 2.2.14
Message-ID: <Springmail.105.1005761843.0.30236800@www.springmail.com>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that was suggested a while ago, in the 2.2 days.  It didn't fly! There was however a general consensus that for small bugs that are found in a 'stable' release there should be fixes for just the bug as the next release.  I.E. 2.2.15 should be released with just the one fix.  Linus didn't seem to go for that as well as some other developers .

If 2.5 was open this kind of thing would probably not happen, but that is not to say that there would not be other issues in 2.4

If someone has the web space, they could as you say, post these 2.4.14.fixme kernels and then also maintain the patches between the official Linus kernel and the fixme kernels.  

J  

Michael Peddemors <michael@wizard.ca> wrote:
> Well, the loopback bug is a pain.. but we have had these pains on quite
a few releases in the 2.4.x series... 

I wonder if maybe a new method of distributing kernels should happen..
2.4.14 should become 2.4.14-stable meaning that it never ever changes
after release, and 2.4.14-fixed means that these tiny typos, gotchas,
and backport driver fixes can get into 2.4.14-fixed which may change
from day to day, but not get any enhancements, only minor fixes..

People could try 2.4.14-stable, and if they have a problem, they could
just try the 2.4.14-fixed to see if their problem is already
addressed...

The idea is that at least every major release kernel should compile, and
it would reduce the noise levels from people trying out *stable* kernel
versions..

Just a thought..

On Mon, 2001-11-12 at 12:27, joeja@mindspring.com wrote:
> I thought that the -pre would be the developer kernels, and that an actual release (2.4.14) would have been somewhat tested.  I fully understand that a 'runtime' bug in the vm or some other system could arrise and that is one thing. I also understand when a 'less used' driver like NTFS or VFAT breaks, but to see bugs in the loop device in a 'stabilizing' kernel is something that I thought I'd never see.
> 

-- 
"Catch the Magic of Linux..."
--------------------------------------------------------
Michael Peddemors - Senior Consultant
LinuxAdministration - Internet Services
NetworkServices - Programming - Security
Wizard IT Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604)589-0037 Beautiful British Columbia, Canada


