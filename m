Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268409AbTCAM7m>; Sat, 1 Mar 2003 07:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268481AbTCAM7l>; Sat, 1 Mar 2003 07:59:41 -0500
Received: from mail.mediaways.net ([193.189.224.113]:56225 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S268409AbTCAM7l>; Sat, 1 Mar 2003 07:59:41 -0500
Subject: re: Linux 2.4.21pre4-ac5 status report
From: Soeren Sonnenburg <kernel@nn7.de>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: szepe@pinerecords.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200303011252.h21CqBpl013357@harpo.it.uu.se>
References: <200303011252.h21CqBpl013357@harpo.it.uu.se>
Content-Type: text/plain
Organization: 
Message-Id: <1046523858.26074.7.camel@sun>
Mime-Version: 1.0
Date: 01 Mar 2003 14:04:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-01 at 13:52, Mikael Pettersson wrote:
> On 01 Mar 2003 11:47:39 +0100, Soeren Sonnenburg wrote:
> >> I've got a single pdc20268 with just one drive on each channel...
> >> Works nicely with recent -ac kernels.
> >
> >As I guessed. I've got two pdc20268 with just one drive per channel
> >(where the last drive is a cdrom-drive)
> >
> >So one pdc no problem >1 -> trouble.
> 
> It might not have anything to do with your problem, but it has
> been reported several times that Promise chips don't support ATAPI
> optical devices (i.e. your CD-ROM) without special driver support,
> which the Linux drivers apparently don't have.

Yes it doesn't have to do with my particular problem as I tried without
an ATAPI cdrom attached.

> Maybe that's changed in 2.4.21-pre-ac new IDE code, I don't know.
> 
> Your cards don't share interrupts with anything else I hope?

sure they do. however it did not work when the pdc's did not share an
IRQ with any other device.

however the htp370 works fine with shared irqs and atapi cdrom.

Soeren.

