Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291485AbSBHJQD>; Fri, 8 Feb 2002 04:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291493AbSBHJPx>; Fri, 8 Feb 2002 04:15:53 -0500
Received: from [217.6.75.131] ([217.6.75.131]:23207 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S291485AbSBHJPj>; Fri, 8 Feb 2002 04:15:39 -0500
Message-ID: <3C6397C5.5749BF8E@internetwork-ag.de>
Date: Fri, 08 Feb 2002 10:17:57 +0100
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Organization: interNetwork AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre9
In-Reply-To: <Pine.LNX.4.21.0202071646550.17201-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

is there any chance for including the latest PPP patch from Paul (2.4.2 -
20020205) and Michael's pppoe patch 0.6.10 -- only those "two" patches eliminate
the PPP deadlocks!  Might be worth putting these into 2.4.18 final ? :-)
Thanks,

Immanuel
Marcelo Tosatti wrote:

> So here it goes.
>
> pre9:
>
> - Cris update                                   (Bjorn Wesen)
> - SPARC update                                  (David S. Miller)
> - Remove duplicate CONFIG_SUNLANCE entry in
>   Config.in                                     (David S. Miller)
> - Change Netfilter maintainer                   (David S. Miller)
> - More SunGEM bugfixes                          (David S. Miller)
> - Update md5sums in ISDN's md5sums.asc          (Kai Germaschewski)
> - 3ware driver update                           (Adam Radford)
> - Fix cosa compile problem                      (Adrian Bunk)
> - Change VIA "disabling write queue" message    (Oliver Feiler)
> - Remove buggy Elan-specific handling code      (Robert Schwebel)
> - Reiserfs bugfixes                             (Oleg Drokin)
> - Fix ppp memory leak                           (Andrew Morton)
> - Really add devfs fix for removable devices:
>   its on pre8 changelog but not on pre8 patch   (me)
> - Add framebuffer support for trident graphics
>   card                                          (James Simmons)
> - SCSI tape driver bugfixes                     (Kai Makisara)
> - Add support to Ovislink card on 8139too
>   driver                                        (Jeff Garzik)
> - Add SIOCxMIIxxxx ioctls for better binary
>   compatibility on au1000_eth driver            (Jeff Garzik)
> - Fix initialization of phy on epic100 driver   (Jeff Garzik)
> - Add MODULE_* info to mii.c                    (Jeff Garzik)
> - Add new PCI ID to sundance driver             (Jeff Garzik)
> - Merge some -ac3 patches                       (Alan Cox)
> - Unify simple_strtol symbol export             (Russell King)
> - Add amount of cached memory to sysreq-m
>   output                                        (Martin Knoblauch)
> - Do not use SCSI device type to change
>   IO clustering                                 (Jens Axboe)
> - IRC conntrack update                          (Harald Welte)
> - sonypi driver update                          (Stelian Pop)
> - Fix one of the PPP deadlocks                  (Manfred Spraul)

