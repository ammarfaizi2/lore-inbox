Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSGMPgA>; Sat, 13 Jul 2002 11:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSGMPf7>; Sat, 13 Jul 2002 11:35:59 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5844 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S314811AbSGMPf5>; Sat, 13 Jul 2002 11:35:57 -0400
Date: Sat, 13 Jul 2002 17:38:32 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207131446.HAA24611@adam.yggdrasil.com>
Message-ID: <Pine.SOL.4.30.0207131736480.75-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 Jul 2002, Adam J. Richter wrote:

> Alan Cox writes:
> |o       Not all ide cdrom devices are ATAPI capable
> [...]
>
> 	Are there some non-ATAPI IDE CDROM's that
> linux-2.5.25/drivers/ide/ide-cdrom.c supports?   I was under
> the impression that ide-cdrom.c operated only through ATAPI.

Wrong impression. ;)
Hint: look for STANDARD_ATAPI macro usage.

--
Bartlomiej

> Adam J. Richter     __     ______________   575 Oroville Road
> adam@yggdrasil.com     \ /                  Milpitas, California 95035
> +1 408 309-6081         | g g d r a s i l   United States of America
>                          "Free Software For The Rest Of Us."

