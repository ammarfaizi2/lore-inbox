Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317730AbSGVTJ1>; Mon, 22 Jul 2002 15:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317748AbSGVTJ1>; Mon, 22 Jul 2002 15:09:27 -0400
Received: from chaos.analogic.com ([204.178.40.224]:23680 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317730AbSGVTJ0>; Mon, 22 Jul 2002 15:09:26 -0400
Date: Mon, 22 Jul 2002 15:13:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ernst Lehmann <lehmann@acheron.franken.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with AMD 768 IDE support
In-Reply-To: <1027364446.26894.2.camel@hadley>
Message-ID: <Pine.LNX.3.95.1020722150712.11545A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jul 2002, Ernst Lehmann wrote:

> Hi,
> 
> I have here a Dual-Athlon Box, with a AMD760MPX Chipset and AMD768 IDE.
> 
> In the base 2.4.18 kernel there seems to be no support for the
> IDE-Chipset

It is supposed to be 'standard'. If you enable:

CONFIG_IDE=y
CONFIG_BLK_DEV_MODES=y
CONFIG_BLK_DEV_HD=y
... it should work. The amd74xx was seperate, it was a "Viper" chip-set.
I believe that the newer AMD Chip-Sets are generic.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

