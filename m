Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268364AbTCAMl4>; Sat, 1 Mar 2003 07:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268409AbTCAMl4>; Sat, 1 Mar 2003 07:41:56 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:55232 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268364AbTCAMlz>;
	Sat, 1 Mar 2003 07:41:55 -0500
Date: Sat, 1 Mar 2003 13:52:11 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200303011252.h21CqBpl013357@harpo.it.uu.se>
To: kernel@nn7.de, szepe@pinerecords.com
Subject: re: Linux 2.4.21pre4-ac5 status report
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Mar 2003 11:47:39 +0100, Soeren Sonnenburg wrote:
>> I've got a single pdc20268 with just one drive on each channel...
>> Works nicely with recent -ac kernels.
>
>As I guessed. I've got two pdc20268 with just one drive per channel
>(where the last drive is a cdrom-drive)
>
>So one pdc no problem >1 -> trouble.

It might not have anything to do with your problem, but it has
been reported several times that Promise chips don't support ATAPI
optical devices (i.e. your CD-ROM) without special driver support,
which the Linux drivers apparently don't have.
Maybe that's changed in 2.4.21-pre-ac new IDE code, I don't know.

Your cards don't share interrupts with anything else I hope?

/Mikael
