Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314646AbSESQrV>; Sun, 19 May 2002 12:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314670AbSESQrV>; Sun, 19 May 2002 12:47:21 -0400
Received: from ns.suse.de ([213.95.15.193]:35334 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314646AbSESQrU>;
	Sun, 19 May 2002 12:47:20 -0400
Date: Sun, 19 May 2002 18:47:20 +0200
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: nVidia NIC/IDE/something support?
Message-ID: <20020519184720.J15417@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205191514.g4JFEsV13608@mail.pronto.tv> <E179T6e-0003x5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2002 at 05:00:24PM +0100, Alan Cox wrote:
 > > I just bought this Asus board, A7N266-VM, with nVidia IDE, LAN and god knows 
 > > chipset. Linux doesn't understand it, and I really want it... Any plans of 
 > > supporting this? See below for /proc/pci output.
 > 
 > Depends if Nvidia want to be helpful. The audio is now supported (someone
 > was able to deduce that it was a clone of the intel one). For the ethernet
 > you might want to try random things that expect that much mmio and I/O 
 > space until you find what they licensed if its not their own

In 2.5 the amd74xx.c ide driver has an entry to support the nforce IDE
too, so it looks like quite a bit of the chipset could be variants of
existing components.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
