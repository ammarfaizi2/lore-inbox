Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264405AbUFPSZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUFPSZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbUFPSZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:25:06 -0400
Received: from smtp-out2.xs4all.nl ([194.109.24.12]:36357 "EHLO
	smtp-out2.xs4all.nl") by vger.kernel.org with ESMTP id S264405AbUFPSYu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:24:50 -0400
Date: Wed, 16 Jun 2004 20:24:15 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: accelerated radeonfb produces artifacts on scrolling in 2.6.7
Message-ID: <20040616182415.GA8286@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The radeonfb driver in 2.6.7 produces some interesting artifacts on
scrolling, both scrolling horizontally and vertically.

When scrolling vertically (in mutt, in slrn, in less) some lines
move horizontally, and corruption occurs. Not all scrolling produces
artifacts, but fairly often.

When scrolling horizontally (most obvious in angband -mcu with the
option 'keep the screen centered' on) corruption appears at once.

Booting with 'noaccel' fixes the problems, but is slow, of course.

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AQ [Radeon 9600]

Kernel command line: root=/dev/md3 video=radeonfb:1600x1200-16@85
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=324.00 Mhz, System=182.00 MHz
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: ATI Radeon AQ  SDR SGRAM 128 MB
Console: switching to colour frame buffer device 133x54

Any hints would be appreciated.

Jurriaan
-- 
All lies all lies all schemes all schemes
Every winner means a loser in the western dream.
	News Model Army - Western Dream
Debian (Unstable) GNU/Linux 2.6.7-rc3-mm2 2x6078 bogomips load load 1.74
