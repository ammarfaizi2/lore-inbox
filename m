Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280161AbRKNG0t>; Wed, 14 Nov 2001 01:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280186AbRKNG0j>; Wed, 14 Nov 2001 01:26:39 -0500
Received: from apollo.wizard.ca ([204.244.205.22]:51717 "HELO apollo.wizard.ca")
	by vger.kernel.org with SMTP id <S280161AbRKNG0Z>;
	Wed, 14 Nov 2001 01:26:25 -0500
Subject: Re: Re: loop back broken in 2.2.14
From: Michael Peddemors <michael@wizard.ca>
To: joeja@mindspring.com
Cc: John Alvord <jalvo@mbay.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Springmail.105.1005596822.0.40719200@www.springmail.com>
In-Reply-To: <Springmail.105.1005596822.0.40719200@www.springmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 13 Nov 2001 22:31:46 -0800
Message-Id: <1005719506.3177.363.camel@mistress>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the loopback bug is a pain.. but we have had these pains on quite
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

