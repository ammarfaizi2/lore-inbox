Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267859AbRGVAvm>; Sat, 21 Jul 2001 20:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267860AbRGVAvc>; Sat, 21 Jul 2001 20:51:32 -0400
Received: from cc668399-a.ewndsr1.nj.home.com ([24.180.97.113]:22525 "EHLO
	eriador.mirkwood.net") by vger.kernel.org with ESMTP
	id <S267859AbRGVAvS>; Sat, 21 Jul 2001 20:51:18 -0400
Date: Sat, 21 Jul 2001 20:51:30 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x problems (this is *not* a distribution related question!)
Message-ID: <Pine.LNX.4.20.0107212047420.5411-100000@eriador.mirkwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Sorry, all.  I realized that my last email seemed to resemble a
distribution question - it's not.  This is about two seperate problems I'm
experiencing under 2.4.x kernels.  The distributions were just mentioned
to illustrate the differences between installs.

If anyone has any ideas on either problem, I'd be more than interested in
seeing them.

Again, I am not subscribed to this list, so please CC me on any replies.

Thanks.


	Mike Edwards

Brainbench certified Master Linux Administrator
http://www.brainbench.com/transcript.jsp?pid=158188
-----------------------------------
Unsolicited advertisments to this address are not welcome.

---------- Forwarded message ----------
Date: Fri, 20 Jul 2001 13:26:12 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
Subject: two seperate 2.4.x problems...

I am not subscribed to this list, so please CC me in any replies.  Thank 
you.


Hey, all.  I have two entirely seperate problems with 2.4.x kernels, on
two seperate systems.

The first occurs on a UDB (Digital Multia, model VX-51, Intel Pentium
100).  I recently installed Slackware 8.0, which includes 2.4.5.  Within a
day of installing, the kernel paniced.  I did not get a chance to save the
text of the oops.  The second time this happened was early this morning,
within a couple hours after a reboot (under 2.4.6).  Text of the oops and
panic are included below (note that this seems similar to the first one -
I noted, at least, that klogd seems to be listed as the culprit in both
cases).

Unable to handle kernel paging request at virtual address 0119c3c1
*pde = 00000000
Oops: 0000
CPU:	0
EIP:	0010:[<c01aba03>]
EFLAGS: 00010006
eax: c119a7d8	ebx: 0119c3a4	ecx: 0119c2cc	edx: 0000004f
esi: 00000010	edi: c119e000	ebp: 0119c2c4	esp: c4633e9c
ds: 0018   es: 0018   ss: 0018
Process klogd (pid: 88, stackpage=c4633000)
Stack: c119e000 c119e000 0000000b c4633f2c c01ac897 c119e000 c119e000 00000246
       0000000b c4633f2c c4633ee8 00000286 c4666300 c01ae8ae c119e000 c11e7460
       04000001 0000000b c0107c8f 0000000b c119e000 c4633f2c 00000160 c029fa60
Call Trace: [<c01ac897>] [<c01ae8ae>] [<c0107c8f>] [<c0107dee>] [<c0106b60>] [<c0110062>] [<c01463d5>]
       [<c012b376>] [<c0106ac3>]

Code: 8a 43 1d 84 c0 7d 09 53 57 e8 5f f9 ff ff eb 0e a9 20 00 00
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

I had to copy this from the screen, so I *may* have typoed some of the
addresses - but I think I got them right.

I previously ran Slackware 7.1 on this system (2.2.16 followed by 2.2.19,
I believe) with no adverse effects.  The problems only started to happen
when I installed Slackware 8.0, and, by extension, the 2.4.x kernels.  I
have not tried 2.2.19 under Slackware 8.0 yet.


The other problem I've been experiencing has to do with SMP and XFree86
4.x.x.  I believe this to be an XFree86 problem, but as they have yet to
respond after several requests for help, and due to the nature of the
problem, it may very well be kernel related.

On a SMP system (dual PIII/1 ghz, VIA chipset) running 2.4.x
(anything up to 2.4.6) kernels and XFree86 4.x.x (I've tried 4.0.1 up to
the current 4.1.0), I can pretty reliably cause the system to lock up.  I
simply start X, switch to a text console, and back to X.  The box locks
up, no keyboard, mouse, or network, and the display is blank.  Only thing
I can do is hit the reset button.  Obviously in such a situation, there
aren't any visible errors, nor are any able to be logged, as nothing is
actually written to disk by the time of the crash.  Under a uniprocessor
kernel, the lockup does *NOT* occur.

Again, I don't know if this is necessarily a kernel problem - trying the
same thing with svgalib doesn't seem to have any adverse effects.


Any help would be *greatly* appreciated.

Thanks!


	Mike Edwards

Brainbench certified Master Linux Administrator
http://www.brainbench.com/transcript.jsp?pid=158188
-----------------------------------
Unsolicited advertisments to this address are not welcome.


