Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287516AbSBCScn>; Sun, 3 Feb 2002 13:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287518AbSBCScX>; Sun, 3 Feb 2002 13:32:23 -0500
Received: from 64-30-107-48.ftth.sac.winfirst.net ([64.30.107.48]:9220 "EHLO
	leng.internal") by vger.kernel.org with ESMTP id <S287516AbSBCScR>;
	Sun, 3 Feb 2002 13:32:17 -0500
Date: Sun, 3 Feb 2002 10:32:16 -0800
From: Manuel McLure <manuel@mclure.org>
To: linux-kernel@vger.kernel.org
Cc: Andre Hedrick <andre@linuxdiskcert.org>
Subject: Re: 2.4.17 Oops when trying to mount ATAPI CDROM
Message-ID: <20020203103216.E12338@ulthar.internal>
In-Reply-To: <20020202170244.A12338@ulthar.internal> <Pine.LNX.4.10.10202021715180.26613-100000@master.linux-ide.org> <20020203102109.C12338@ulthar.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020203102109.C12338@ulthar.internal>; from manuel@mclure.org on Sun, Feb 03, 2002 at 10:21:09 -0800
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.02.03 10:21 Manuel McLure wrote:
> 
> On 2002.02.02 22:04 Andre Hedrick wrote:
> >
> > Manuel,
> >
> > Would you be kind enough to be a little more specific on the hardware?
> > The attached devices bu make model and real vender if known.
> kml/
> 
> The CD-ROM is detected as a Pioneer CD-ROM ATAPI Model DR-A24X 0104 - I
> haven't opened the case to look at it but I do recall that it is
> definitely a 24X Pioneer ATAPI CDROM.
> 

Some more information - if I boot without "hdc=noprobe hdc=cdrom", I don't 
get the oops whel loading the "ide-cd" module - instead I get

hdc: set_drive_speed_status: status=0x00 { }
hdc: lost interrupt
hdc: ATAPI 20X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt

The module eventually finishes initializing but is not usable due to the 
"lost interrupt"s.

-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft
