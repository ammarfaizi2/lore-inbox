Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287644AbRLaUic>; Mon, 31 Dec 2001 15:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287481AbRLaUiW>; Mon, 31 Dec 2001 15:38:22 -0500
Received: from peabody.ximian.com ([141.154.95.10]:17163 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP
	id <S287642AbRLaUiO>; Mon, 31 Dec 2001 15:38:14 -0500
Subject: 2.4.17 not booting on ThinkPad
From: Kevin Breit <mrproper@ximian.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2001.12.21.18.01 (Preview Release)
Date: 31 Dec 2001 15:44:35 -0600
Message-Id: <1009835075.1404.0.camel@192>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
        For some reason, beyond my comprehension, 2.4.17 doesn't seem to
want to boot on my IBM iSeries 1300 1171-NM1 laptop.
        To compile the kernel, I took RedHat 7.2's config-i686 file,
moved it into .config, ran a make oldconfig, and ran the kernel.  The
boot dies when I get to:

hda: 19640880 sectors (10056 MB) w/384KiB Cache, CHS=1222/255/63,
UDMA(33)
ide-floppy driver 0.97.sv
Partition check:
 hda: hda1 hda2 hda3

The hard disk light stays on and the system freezes entirely (as in Caps
Lock won't work either).

If anyone has any pointers, I'd appreciate the help!

Thanks

Kevin Breit

