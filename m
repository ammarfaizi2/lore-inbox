Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284823AbSACJNX>; Thu, 3 Jan 2002 04:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284761AbSACJNO>; Thu, 3 Jan 2002 04:13:14 -0500
Received: from bs1.dnx.de ([213.252.143.130]:26347 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S284956AbSACJNC>;
	Thu, 3 Jan 2002 04:13:02 -0500
Date: Thu, 3 Jan 2002 10:04:13 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, <rkaiser@sysgo.de>
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <3C33918E.7080409@zytor.com>
Message-ID: <Pine.LNX.4.33.0201030954440.3056-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, H. Peter Anvin wrote:
> It's end of lifed in this particular product, does that mean the core
> itself won't find itself embedded in something? ...

The probability is rather low, as the 486 cores are definitely a dying
species. AMD is, as many other manufacturers, going the 586 way on it's
embedded roadmaps, as modern embedded 586 cores have the same low power
requirements and there are designs available which have all the advantages
of the [34]86s but a more modern core and stuff like PCI interfaces.

But nevertheless, relying on assumptions is no good design, so we should
stay with the current solution. If somebody adds stuff for the SC520 it
should be no problem to add something for differentiation.

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

