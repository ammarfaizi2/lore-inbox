Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267937AbRHRUhG>; Sat, 18 Aug 2001 16:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267621AbRHRUg6>; Sat, 18 Aug 2001 16:36:58 -0400
Received: from pille1.addcom.de ([62.96.128.35]:7955 "HELO pille1.addcom.de")
	by vger.kernel.org with SMTP id <S267836AbRHRUgp>;
	Sat, 18 Aug 2001 16:36:45 -0400
Date: Sat, 18 Aug 2001 22:36:40 +0200 (CEST)
From: Frank Neuber <frank.neuber@gmx.de>
To: Andre Hedrick <andre@aslab.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUGFIX: UDMA-SiS5513 chipset support
In-Reply-To: <Pine.LNX.4.10.10108181211530.24147-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.3.96.1010818223002.5810B-100000@mars.private.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hedrick,
I was looking for an option such as "nodma" and I did't found it.
The option "autodma" I had never set. Or should I undefine this in the
source?
Maybe my hdd is broken, the original driver works well with my
ATAPI-CD-DRIVE.

Thanks for your response
 Frank 

On Sat, 18 Aug 2001, Andre Hedrick wrote:
> 
> Not the correct solution, you should not set autodma.
> This will prevent DMA from being used at INIT; however, you can still
> attempt it later.  This patch is an invalid solution, period.

--
     _/_/_/_/ _//   _/ Frank Neuber
    _/       _/_/  _/  frank.neuber@gmx.de (private)
   _/_/_/   _/ _/ _/
  _/       _/  _/_/    neuber@opensource-systemberatung.de
 _/       _/    // http://www.opensource-systemberatung.de

