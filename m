Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265353AbSIWKRV>; Mon, 23 Sep 2002 06:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265357AbSIWKRV>; Mon, 23 Sep 2002 06:17:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26121 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265353AbSIWKRU>;
	Mon, 23 Sep 2002 06:17:20 -0400
Message-ID: <3D8EEB48.6010105@mandrakesoft.com>
Date: Mon, 23 Sep 2002 06:22:00 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Stevenson <james@stev.org>
CC: Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via82cxxxx.c ?
References: <017801c262eb$010a3d00$0cfea8c0@ezdsp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Stevenson wrote:
> Hi
> 
> i have the following on motherboard card.
> 
>  Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio
> Controller (rev 48).
> 
> there appears ot be a driver for it. But i am havign a few problems with it
> when the driver loads it says it picks the card up no problem
> and stays loaded and has the ioports, irq in /proc/*


sounds like an old kernel -- the driver doesn't support your chip at 
all.  I removed the pci id in later kernels so it wouldn't even load.

It needs VT8233 support added to it (on my todo list), or you can use 
ALSA, which supports VT8233.

	Jeff


