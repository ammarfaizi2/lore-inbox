Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbUFKIsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUFKIsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 04:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUFKIsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 04:48:25 -0400
Received: from guardian.hermes.si ([193.77.5.150]:53001 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S262009AbUFKIsW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 04:48:22 -0400
Message-ID: <600B91D5E4B8D211A58C00902724252C01BC06BB@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: "'grub-devel@gnu.org'" <grub-devel@gnu.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Grub 1 troubleshooting, linux boot delayed problem
Date: Fri, 11 Jun 2004 10:48:13 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="ISO-8859-2"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I found no other place, so I'll ask here.

I have a problem booting linux with grub ( v 0.9.something ).

I use the commands ( in the grub shell that boots from my HD ):
root (hd0,0)
kernel /vmlinuz-2.6.xxx ro root=dev/hda2
initrd /initrd-2.xxx
boot

After entering the "boot" command, the screen is cleared and then nothing
happens for 93 seconds.
After that linux boot normally ( beginning with the message "Uncompressing
linux..." and so on ).
If I trim the kernel command line to only "kernel /vmlinuz-2.6.xxx ro" ,
then the delay is 10 seconds.

If I change the operating mode of the IDE adapter in BIOS to RAID, then the
delay is infinite ( I waited
8 hours ). Note that GRUB still loads andit can browse and "cat" files on
the disk, so it is not a disk
access problem.

Can someone tell me how to find out what GRUB is doing after the "boot"
command ?
I tried to run "debug on" first, but it makes no change at all.

Maybe this is a linux kernel problem.

Any help appreciated !

Regards,
David Bala¾ic

P.S.: It is a Fedora Core 2 system, the exact version numbers are
grub-0.94-5 , kernel-2.6.5-1.358

P.P.S.: I know this is Red Hat related, but my question is general : What is
happening between
the GRUB "boot" command and linux printing "Uncompressing linux..." ?
----------------------------------------------------------------------------
-----------
http://noepatents.org/           Innovation, not litigation !
---
David Balazic                      mailto:david.balazic@hermes.si
HERMES Softlab                 http://www.hermes-softlab.com
Zagrebska cesta 104            Phone: +386 2 450 8851 
SI-2000 Maribor
Slovenija
----------------------------------------------------------------------------
-----------
"Be excellent to each other." -
Bill S. Preston, Esq. & "Ted" Theodore Logan
----------------------------------------------------------------------------
-----------








