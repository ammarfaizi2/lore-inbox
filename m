Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317217AbSG2OKY>; Mon, 29 Jul 2002 10:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSG2OKY>; Mon, 29 Jul 2002 10:10:24 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:30476 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317217AbSG2OKY>; Mon, 29 Jul 2002 10:10:24 -0400
Date: Mon, 29 Jul 2002 11:13:05 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Nandakumar NarayanaSwamy <nanda_kn@rediffmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel crash in fault.c
In-Reply-To: <20020729111314.32557.qmail@mailFA12.rediffmail.com>
Message-ID: <Pine.LNX.4.44L.0207291109520.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jul 2002, Nandakumar  NarayanaSwamy wrote:

> When the kernel boots up, it identifies my device (hardware
> device) and allocates memory and fixup irq for that.
> Mean while in driver i am registering the driver using,
> pci_register_driver. When i tried to access (write a word) the
> PCI
> memory space allocated for my device, the kernel crashes saying
> "Unable to handle kernel paging request at virtual address "
> in fault.c function : do_page_fault?
>
> Can anyone throw a light on this?

Are you using bus_to_virt (or whatever that thing is called now)
to translate the bus address to a memory address or are you taking
the bus address and trying to write to that memory address ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

