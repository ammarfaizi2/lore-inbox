Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318302AbSIBN7t>; Mon, 2 Sep 2002 09:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318304AbSIBN7t>; Mon, 2 Sep 2002 09:59:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37602 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318302AbSIBN7t>; Mon, 2 Sep 2002 09:59:49 -0400
Date: Mon, 2 Sep 2002 16:04:14 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Samuel Flory <sflory@rackable.com>, Gerd Knorr <kraxel@bytesex.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre4 depmod errors
In-Reply-To: <1029875932.5308.100.camel@flory.corp.rackablelabs.com>
Message-ID: <Pine.NEB.4.44.0209021559250.147-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Aug 2002, Samuel Flory wrote:

> minor depmod issues:
>
> [root@gorn linux-2.4.20-pre4]# /sbin/depmod -ae -F System.map
> 2.4.20-pre4
>...
> /lib/modules/2.4.20-pre4/kernel/drivers/media/video/bttv.o
> depmod:         mod_firmware_load_Rsmp_39e3dd23
> [root@gorn linux-2.4.20-pre4]#


Your kernel doesn't include any sound support? A workaround is to say "M"
at "Sound/Sound card support" (you don't need any of the drivers below).

I've sent a mail to Gerd Knorr explaining the cause of this problem a few
minutes ago.


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

