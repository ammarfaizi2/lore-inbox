Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269740AbRHMCoY>; Sun, 12 Aug 2001 22:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269757AbRHMCoO>; Sun, 12 Aug 2001 22:44:14 -0400
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:27083 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S269740AbRHMCoF>; Sun, 12 Aug 2001 22:44:05 -0400
Date: Sun, 12 Aug 2001 22:44:09 -0400 (EDT)
From: <kryten@darkaxis.com>
X-X-Sender: <kryten@Trypticon.cybertron.lan>
Reply-To: <kryten@darkaxis.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 5
In-Reply-To: <3B77361B.6020302@xmission.com>
Message-ID: <Pine.LNX.4.31.0108122243250.3522-100000@Trypticon.cybertron.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2001, Frank Jacobberger wrote:

> Where is kernel development with respect to ATA 100
> IDE drives? The only param idebus=xx takes is 66... are
> there plans to go to 100?
>
> Running 2.4.8 here
>
> Frank

idebus is for specifying the PCI bus speed. That should be "33" for
most systems unless it's overclocked. It has nothing to do with UDMA.
ATA100 support has been in the kernel for some time. Just select Use DMA
in the kernel config and select the proper motherboard chipset and you
should be fine.



---------------------
This message powered
by Pine and GNU/Linux

