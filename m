Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264199AbTE0VmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264200AbTE0VmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:42:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:35250 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264199AbTE0Vly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:41:54 -0400
Date: Tue, 27 May 2003 18:53:06 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc5
In-Reply-To: <8765nw2js3.fsf@sycorax.lbl.gov>
Message-ID: <Pine.LNX.4.55L.0305271852330.23144@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0305271640320.9487@freak.distro.conectiva>
 <8765nw2js3.fsf@sycorax.lbl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 May 2003, Alex Romosan wrote:

> Marcelo Tosatti <marcelo@conectiva.com.br> writes:
>
> > Mainly due to a IDE DMA problem which would happen on boxes with lots of
> > RAM, here is -rc5.
> >
> > As I always ask, please test.
>
> i get the following error:
>
> make[5]: Entering directory `/usr/src/linux/drivers/ide/pci'
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -I../ -nostdinc -iwithprefix include -DKBUILD_BASENAME=via82cxxx  -c -o via82cxxx.o via82cxxx.c
> via82cxxx.c:77: error: `PCI_DEVICE_ID_VIA_8237' undeclared here (not in a function)

Get the latest BK tree.

I will have to release -rc6 (will probably do later tonight, maybe
something else shows up).
