Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314670AbSESROi>; Sun, 19 May 2002 13:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSESROh>; Sun, 19 May 2002 13:14:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26894 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314670AbSESROg>; Sun, 19 May 2002 13:14:36 -0400
Subject: Re: nVidia NIC/IDE/something support?
To: davej@suse.de (Dave Jones)
Date: Sun, 19 May 2002 18:34:15 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        roy@karlsbakk.net (Roy Sigurd Karlsbakk), linux-kernel@vger.kernel.org
In-Reply-To: <20020519184720.J15417@suse.de> from "Dave Jones" at May 19, 2002 06:47:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179UZT-00046i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Depends if Nvidia want to be helpful. The audio is now supported (someone
>  > was able to deduce that it was a clone of the intel one). For the ethernet
>  > you might want to try random things that expect that much mmio and I/O 
>  > space until you find what they licensed if its not their own
> 
> In 2.5 the amd74xx.c ide driver has an entry to support the nforce IDE
> too, so it looks like quite a bit of the chipset could be variants of
> existing components.

Even more interesting is that the AMD audio is also a clone of the i810.
So that makes the AMD audio and AMD ide apparently match the Nvidia audio
and Nvidia ide (minus the Nvidia extra 'media controller')

Unfortunately the AMD PCnetXX ethernet doesn't match up with the amount
of I/O space their ethernet has.

Alan
