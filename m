Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288995AbSAFRjv>; Sun, 6 Jan 2002 12:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288994AbSAFRjl>; Sun, 6 Jan 2002 12:39:41 -0500
Received: from gate.perex.cz ([194.212.165.105]:25093 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S288896AbSAFRjZ>;
	Sun, 6 Jan 2002 12:39:25 -0500
Date: Sun, 6 Jan 2002 18:39:11 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: ALSA development <alsa-devel@alsa-project.org>
cc: "sound-hackers@zabbo.net" <sound-hackers@zabbo.net>,
        "linux-sound@vger.rutgers.edu" <linux-sound@vger.rutgers.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: ALSA patch for 2.5.2pre9 kernel
Message-ID: <Pine.LNX.4.31.0201061814580.545-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

	I would like to introduce the ALSA kernel patches URL:

ftp://ftp.alsa-project.org/pub/kernel-patches

The latest patch is alsa-2002-01-06-1-linux-2.5.2pre9.patch.gz and
contains:

* moved linux/drivers/sound directory to linux/sound/oss
* moved sound core files to linux/sound
* integrated ALSA kernel code
  - linux/include/sound - sound header files
  - linux/sound/core	- midlevel (no hw dependent) code
  - linux/sound/drivers - generic drivers (no arch dependent)
  - linux/sound/i2c     - reduced I2C core and drivers
  - linux/sound/isa	- ISA sound hardware drivers
  - linux/sound/pci	- PCI sound hardware drivers
  - linux/sound/ppc	- PowerPC sound hardware drivers
  - linux/sound/synth	- generic synthesizer support code

We appreciate any comments regarding directory structure (not being
finally approved by Linus due a lot of work on new BIO) or the ALSA
code itself. We are trying to separate the compatibility code for 2.2 and
2.4 kernels to other location in our CVS so the Linux kernel will
not be messed with this stuff.

If you post a reply or comment regarding ALSA to lkml, please, CC: me
directly or to our development mailing list <alsa-devel@alsa-project.org>.

					Yours,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA Project  http://www.alsa-project.org

