Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268117AbRG3VSH>; Mon, 30 Jul 2001 17:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268118AbRG3VR5>; Mon, 30 Jul 2001 17:17:57 -0400
Received: from umail.unify.com ([204.163.170.2]:46035 "EHLO umail.unify.com")
	by vger.kernel.org with ESMTP id <S268117AbRG3VRr>;
	Mon, 30 Jul 2001 17:17:47 -0400
Message-ID: <419E5D46960FD211A2D5006008CAC79902E5C3ED@pcmailsrv1.sac.unify.com>
From: "Manuel A. McLure" <mmt@unify.com>
To: "'Dan Hollis'" <goemon@anime.net>, Kurt Garloff <garloff@suse.de>
Cc: "James A. Treacy" <treacy@home.net>, linux-kernel@vger.kernel.org
Subject: RE: PROBLEM: Random (hard) lockups
Date: Mon, 30 Jul 2001 14:17:33 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Dan Hollis wrote: 
> On Mon, 30 Jul 2001, Kurt Garloff wrote:
> > On Sun, Jul 29, 2001 at 02:34:01PM -0400, James A. Treacy wrote:
> > > The machine is a 1GHz Athlon (266) on an MSI K7T Turbo 
> with 256M ram,
> > A 1.2GHz Athlon with the very same motherboard and the same 
> amount of RAM
> > seems to be stable with 2.4.7 and PPro or K6 optimizations 
> and crashes
> > during the init procedure if the kernel is optimized for K7.
> 
> Perhaps someone can make a test case .c program which uses K7
> optimizations to smash memory? It would be nice to be able to pin this
> down. Obviously, the standard memory testers aren't catching it.
> 
> Is this only happening on DDR systems?
> 
> -Dan


I am seeing something very similar on my K7T Turbo/Athlon 900/256M PC133
SDRAM (note to Dan, the K7T Turbo is an SDRAM mobo, not DDR) - 2.4.6 worked
fine with no hangs/oopses but 2.4.7 will suddenly hang after an uptime of a
day or two. Sysrq-b will reboot, but Sysrq-s and Sysrq-u seem to be
ineffective, and the machine won't respond to pings. Of course, I'm always
in X when this happens so I don't see any oops information (whatever
happened to the "write oops to floppy" patches?). Both 2.4.6 and 2.4.7 are
compiled with K7 optimizations turned on.

--
Manuel A. McLure - Unify Corp. Technical Support <mmt@unify.com>
Zathras is used to being beast of burden to other peoples needs. Very sad
life. Probably have very sad death, but at least there is symmetry.
