Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbRFAURg>; Fri, 1 Jun 2001 16:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbRFAUR0>; Fri, 1 Jun 2001 16:17:26 -0400
Received: from sun.plan9.de ([213.69.218.222]:34742 "EHLO mailout.plan9.de")
	by vger.kernel.org with ESMTP id <S261459AbRFAURO>;
	Fri, 1 Jun 2001 16:17:14 -0400
Date: Fri, 1 Jun 2001 22:16:37 +0200
From: Marc Lehmann <pcg@goof.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Au-Ja <doelf@au-ja.de>, Yiping Chen <YipingChen@via.com.tw>,
        support@msi.com.tw, info@msi-computer.de, support@via-cyrix.de,
        John R Lenton <john@grulic.org.ar>
Subject: Re: VIA's Southbridge bug: Latest (pseudo-)patch
Message-ID: <20010601221637.B13797@cerebro.laendle>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Axel Thimm <Axel.Thimm@physik.fu-berlin.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Au-Ja <doelf@au-ja.de>, Yiping Chen <YipingChen@via.com.tw>,
	support@msi.com.tw, info@msi-computer.de, support@via-cyrix.de,
	John R Lenton <john@grulic.org.ar>
In-Reply-To: <20010519110721.A1415@pua.nirvana> <20010601171848.F467@cerebro.laendle> <3B17B4B0.9A805766@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3B17B4B0.9A805766@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Jun 01, 2001 at 11:28:48AM -0400
X-Operating-System: Linux version 2.4.5 (root@cerebro) (gcc version 2.95.2.1 19991024 (release)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2001 at 11:28:48AM -0400, Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> Once you get into the area of flushing data (or not flushing, which is
> what delayed txn would imply), it is entirely possible that the driver
> simply does not support what occurs when the PCI Delay Txn option is
> set.

Aren't PCI delayed transaction supposed to be handled by the pci master
(e.g. my northbridge), not by the (software) driver for my pdc(?) I would
also be surprised if my pdc actually used that feature, not to speak of
the fact that the promise + harddisk worked fine in another computer (the
data corruption was easily detectable, one couldn't even write 500megs
without altered bytes).

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
