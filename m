Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265877AbSIRJuG>; Wed, 18 Sep 2002 05:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbSIRJuF>; Wed, 18 Sep 2002 05:50:05 -0400
Received: from 62-190-218-52.pdu.pipex.net ([62.190.218.52]:54283 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S265877AbSIRJuF>; Wed, 18 Sep 2002 05:50:05 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209181002.g8IA2w52001416@darkstar.example.net>
Subject: Re: Question about the dd command
To: tcheer@gmx.de (Eric Tchepannou)
Date: Wed, 18 Sep 2002 11:02:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <18955.1032342092@www26.gmx.net> from "Eric Tchepannou" at Sep 18, 2002 11:41:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I am trying to build a boot image in order to boot from a CD device. I have
> already created all the parts ( Kernel, Lilo and Rootfs ) and try to bring
> them together. I first copied it on a floppy in order to see wether I could
> boot from it and  it worked. In the Linux-Bootdisk-HOWTO It is said that on
> should transfer the rootfs with the following command
> 
> dd if=rootfs of=/dev/fd0 bs=1k seek=KERNEL_BLOCKS 
> 
> I calculated the KERNEL_BLOCK value in my case and applied the command. It
> is supposed to transfer the rootfs file into the same floppy containing the
> kernel. I am surprised to see that with a ls-command the rootfs.gz is invisible
> on the floppy, though the boot process from floppy works properly. Later i
> created an image of the floppy ( dd if=/dev/fd0 of=boot.img bs=10k count=144
> as in the Linux-Bootdisk-HOWTO ), created an iso file from it with mkisofs and
> copied it on CD. Now I can't boot the image from this CD!

I'm assuming that you're trying to create a bootable CD for an X86 machine.

In that case, this is not how bootable CDs work.  You need to look up the 'El-Torito' bootable CD specs, and take it from there.

John.
