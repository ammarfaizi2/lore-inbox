Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278057AbRJIXev>; Tue, 9 Oct 2001 19:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277263AbRJIXeg>; Tue, 9 Oct 2001 19:34:36 -0400
Received: from apollo.wizard.ca ([204.244.205.22]:26118 "HELO apollo.wizard.ca")
	by vger.kernel.org with SMTP id <S277020AbRJIXeX>;
	Tue, 9 Oct 2001 19:34:23 -0400
Subject: Framebuffer detection problems, 2.4.9
From: Michael Peddemors <michael@wizard.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 09 Oct 2001 16:38:15 -0700
Message-Id: <1002670696.4112.285.camel@mistress>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seldom dive into the graphical end of things myself, but this one has
had me stumped for the last week and a half..

I have a working ThinClient setup, that loads it's kernel via tftpd and
mknbi, with the 'vga=ask' option..
On one machine, with a Cirrus Logic card, (Cirrus Framebuffer support
compiled in) things work fine, but on all my other boxes with VESA
complaint cards, I cannot get it to use the VESA framebuffer, or
seemingly to detect the VESA devices with this kernel, although we can
on detect and pass modes using LILO on similar kernels.

I have of course read as many how-to's as possible, and the svga.txt
file seems to indicate that if I use the vga=ask option, and then run
scan it should show all VESA modes as well, (It does detect it as a VESA
VGA card), but the /fb/vesafb.txt seems to indicate that it won't show
the modes..

I see that in video.S CONFIG_VIDEO_VESA is harddefined, but I cannot
quite understand why I cannot enter a VESA mode that works..
I tried 313, 0313, and the decimal equivs 787 and 0787 but it keeps
returning that as an invalid mode..  This occurs on several machines,
all with recent video cards, that are VESA compliant, and listed as
compatible.. the motherboards all use recent BIOS's but still no joy..

I will accept help here, or can someone point me to a good mailing list
to work this out?

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

