Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbTA1KcF>; Tue, 28 Jan 2003 05:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbTA1KcF>; Tue, 28 Jan 2003 05:32:05 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:52750 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265065AbTA1KcE>; Tue, 28 Jan 2003 05:32:04 -0500
Date: Tue, 28 Jan 2003 13:40:49 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Martin Mares <mj@ucw.cz>, Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
Message-ID: <20030128134049.B9195@jurassic.park.msu.ru>
References: <20030128132406.A9195@jurassic.park.msu.ru> <Pine.GSO.4.21.0301281126390.9269-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0301281126390.9269-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Jan 28, 2003 at 11:27:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 11:27:21AM +0100, Geert Uytterhoeven wrote:
> > This can be overridden in <asm/pci.h>.
> 
> Although legacy resources exist on non-PCI as well.

Sure, but it's ok to include <linux/pci.h> and use stub PCI
interfaces even if CONFIG_PCI is not set.

Ivan.
