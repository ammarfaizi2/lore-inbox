Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWCLSPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWCLSPg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 13:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWCLSPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 13:15:36 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:24765 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750875AbWCLSPg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 13:15:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UWTBTCLmEbX39CGRiES+Z6Y4prSIsC+EpsmCCB3xA+IwY+NmNFZyemf1mI0XQdr6gtPHRPpxOf2+Z7w2YozSvRqHX6utIsodsF+qSsKEEjxhcFEXJQzk+fPaOxT7jN3vZ7Iata+yjjdDvV53aMr88Tk7kr+bLoG3bPV2KS3Bwb0=
Message-ID: <436c596f0603121015j2a091ab2sf43d0c5c396bbb72@mail.gmail.com>
Date: Sun, 12 Mar 2006 15:15:34 -0300
From: j4K3xBl4sT3r <jakexblaster@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel config problem between 2.4.x to 2.6.x!
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all I would like to show my PC hardware:

Athlon 700Mhz processor
Asus K7M mobo (Via chipsets, sound, modem and network offboard)
SoundBlaster 16 (ISA bus)
Diamond Stealth III / A200 (core S3 Savage 4)
128 MB RAM PC100
DVDROM/CDRW LG GCC-44800
NIC LG 10/100 - core Via Rhine, from mobo
Mouse connected through a HID device

Network connection through a DSL modem (using eth0) by PPPoE

I've tried to configure a linux system with the minimal and updated
software, using the linuxfromscratch.org books. Tried 4 times before
finishing it, took a long time, 2 weeks, due to some experiences and
time loss (some softwares compiled/tested for a very long time, like
GLibC and GetText, around 1 hour+). Currently I have a targz of this
system, Kernel 2.6.15.4 (recent one) with GCC 4.0.2, Binutils 2.15.4
and GLibC 2.3.6.

I tried also installing the lastest Slackware (10.2, comes with 2.4.x
kernel) distro, got it working very well, until installed the Kernel
2.6.x.

The problem is:

1. On the slack system, when I install the 2.6.x, everything on the
system starts crashing, the Xorg doesnt starts anymore, the network
doesnt works anymore (DSL by PPPoE), and also the sound.

2. On my own distro, I've started with the 2.6.x kernel, but still
getting the network problem, and the sound card doesnt work, the
PNPDUMP finds nothing, the ALSA simply doesnt work too, and I get some
errors, that doesnt happen on the 2.4.x system, while compiling the
Net-Tools package (linuxfromscratch doesnt consider it as essential on
the LFS book, it just appears over the BLFS book).

Any suggestion? The config of my kernel includes ACPI, APM, ALSA, Elf
a.out and misc binaries as build-in, ext2 and ext3 built-in, Netfilter
as module (tried also as built-in), VESA VGA / Framebuffer, SCSI and
IDE drivers, USB mass storage.

Thanks in advance,
jake.
