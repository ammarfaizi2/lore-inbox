Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbUKGAj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbUKGAj0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 19:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUKGAj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 19:39:26 -0500
Received: from bgm-24-95-139-53.stny.rr.com ([24.95.139.53]:23957 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261504AbUKGAjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 19:39:21 -0500
Subject: KVM ps mouse wheel problems
From: Steven Rostedt <rostSPAMMERedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Sat, 06 Nov 2004 19:39:22 -0500
Message-Id: <1099787962.8008.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a 2.6.9 kernel (downloaded from kernel.org) for a computer I put
together. (Tyan motherboard with 2 Athlon MPs). I have a logitech
wireless USB mouse plugged into a miniview ps/2 KVM switch (with the
supplied USB to ps/2 converter), with the miniview KVM switch connected
to the ps/2 port of the computer.  I'm running on a Debian system and
the problem also exists with the debian 2.6.9 k7 smp build.

The problem: it seems that when I use the mouse wheel, the button 2 and
3 are randomly clicked, and is very annoying.  The scrolling still works
but I'm getting noise that seems to cause the other buttons to click.

Some trouble shooting: With the same setup, the 2.4 kernels work with no
problem. With the 2.6.9 kernels, it also works whether I hook the
logitech mouse straight to the USB port or to the ps/2 port through the
converter.  So it seems that the problem is between the KVM switch and
the 2.6.9 kernel.

I've googled and found problems where the problem occurs after a switch
and the wheel mouse stops functioning. This is not my problem.  This
happens without a switch, and the wheel mouse works but I seem to get
some noise that causes these extra clicks.  If I slowly wheel the mouse
upwards, then the button 2 always clicks (not the wheel mouse button,
but the one to the right of it). 

Also note that with the ps/2 connected directly, I get in the logs 
"ImExPS/2 Logitech Explorer Mouse on isa0060/serio1"
through the KVM I get:
"ImExPS/2 Generic Explorer Mouse on isa0060/serio1"

Any ideas? 

I'm working on a new system and I am just rejoining the list. Since my
email doesn't match my real address I must first be approved.  I
wouldn't usually ask this, but if you reply, could you please CC me at 
rostedt at goodmis dot org. (so much spam, I'm trying to save myself).

Thanks in advance!

-- 
Steven Rostedt
Senior Engineer
Kihon Technologies
