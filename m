Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130470AbRCTQSU>; Tue, 20 Mar 2001 11:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRCTQSB>; Tue, 20 Mar 2001 11:18:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:24072 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130470AbRCTQRr>; Tue, 20 Mar 2001 11:17:47 -0500
Date: Tue, 20 Mar 2001 08:16:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
cc: <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>
Subject: Re: PCMCIA serial CardBus support vanished in 2.4.3-pre3 and later
In-Reply-To: <3AB732F0.CE13E52F@oracle.com>
Message-ID: <Pine.LNX.4.31.0103200815250.1503-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Mar 2001, Alessandro Suardi wrote:
>
>  2.4.3-pre3 and synced-up versions of the -ac series remove support for
>  PCMCIA serial CardBus. In drivers/char/pcmcia the Makefile and Config.in
>  files are modified to exclude serial_cb and the serial_cb.c file itself
>  is removed by the patch. As a net result, my Xircom modem port becomes
>  invisible to the kernel and I can't dial out through it.

The regular serial.c should handle it natively. Just make sure you have
CONFIG_SERIAL enabled, along with hotplugging support etc.

		Linus

