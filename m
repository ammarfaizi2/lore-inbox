Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313986AbSDKErc>; Thu, 11 Apr 2002 00:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313987AbSDKErb>; Thu, 11 Apr 2002 00:47:31 -0400
Received: from ns0.tateyama.or.jp ([210.128.170.1]:49419 "HELO
	ns0.tateyama.or.jp") by vger.kernel.org with SMTP
	id <S313986AbSDKEra> convert rfc822-to-8bit; Thu, 11 Apr 2002 00:47:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gabor Kerenyi <wom@tateyama.hu>
To: Ed Vance <EdV@macrolink.com>
Subject: Re: how to write driver for PCI cards
Date: Thu, 11 Apr 2002 13:52:29 +0900
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A776C@EXCHANGE>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200204111352.29829.wom@tateyama.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 April 2002 01:18, Ed Vance wrote:

> > There is a good news (at least for me), my company would like to
> > have a Linux driver for its card. And this great task is mine.
> > So I'm going to write a driver.
>
> What kind of card is it? serial, SCSI, network? ...

It is a PLC/NC (Programmable Logic Controller) now for Compact PCI.

> > Can anyone give me some online docs about PCI bus? (I found some
> > info about PCI-9050 chip but it doesn't contain what I need.)
>
> Did you mean PLX-9050 PCI interface chip? This is a widely used chip
> and should have several examples. If your device uses interrupts, you
> will need to know how the kind of interrupt sources (edge, level) and
> how they are connected to the 9050.

Yes it is  a PLX-9050. The device uses interrupts, but why should I have to 
know that what type of interrupt it is? Until now I haven't found anything 
describing it.
I could find out from the docs that it uses memory I/O and everything is done 
through a 8K buffer.

Gabor

