Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265260AbUAJQKL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 11:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUAJQKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 11:10:11 -0500
Received: from [81.3.4.101] ([81.3.4.101]:14026 "HELO localhost")
	by vger.kernel.org with SMTP id S265260AbUAJQKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 11:10:02 -0500
From: "Christian Kivalo" <valo@valo.at>
To: "Alex" <alex@meerkatsoft.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Cannot boot after new Kernel Build
Date: Sat, 10 Jan 2004 17:10:01 +0100
Message-ID: <NMEHJKFGFEGJPIPOLFFEIEBEDEAA.valo@valo.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <40001D91.40702@meerkatsoft.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> I tried changing the fstab, removing the LABLE from the grub.conf,
> removing initrd from it and also tried to boot with
> /dev/hda3.  Nothing
> works, still the same problem.

hi!

you don't have to change your fstab, there should everything ok with you
fstab.

you should change the root= entry in your grub configuration to your
actual root partition. if you don't know what partition your root is on,
do a 'df' and look where '/' is mounted on.

the second line of df output should read somewhat similar to:
/dev/sda2              4806936   1611232   2951516  36% /

that's my fileserver where /dev/sda2 is mounted as '/'.

your root= in grub config should read somewhat like this:
root=/dev/hda1)

hth
christian

>
> Alex
>

