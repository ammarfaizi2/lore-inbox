Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316775AbSHJKFZ>; Sat, 10 Aug 2002 06:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSHJKFZ>; Sat, 10 Aug 2002 06:05:25 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41957 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316775AbSHJKFY> convert rfc822-to-8bit; Sat, 10 Aug 2002 06:05:24 -0400
Date: Sat, 10 Aug 2002 12:09:05 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: =?iso-8859-2?Q?Pawe=B3?= Krawczyk <kravietz@aba.krakow.pl>
cc: zhengchuanbo <zhengcb@netpower.com.cn>,
       "linux-kernel @ vger. kernel. org" <linux-kernel@vger.kernel.org>
Subject: Re: about the tuning of eepro100
In-Reply-To: <20020810095126.GF21239@aba.krakow.pl>
Message-ID: <Pine.NEB.4.44.0208101206460.3636-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Aug 2002, [iso-8859-2] Pawe³ Krawczyk wrote:

> On Sat, Aug 10, 2002 at 05:38:39PM +0800, zhengchuanbo wrote:
>
> > so i think the limit is at the eepro100 card. is there any way to improve the throughput? or someone got a higher throughput then that?
> > the eepro100 chip is 82559.
>
> Use e100 driver from Intel [1] with the following parameters:
>
> insmod e100.o BundleSmallFr=1 IntDelay=0x600 ucode=1
>
> Intel's driver supports all the interrupt saving features (interrupt
> delay and small packet bundling) present in EEPro/100 cards. The driver
> is now GPL, so it should get back to the mainstream kernel.
>...

Intel's driver is already in 2.4.20-pre1.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

