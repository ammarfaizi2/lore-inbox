Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265225AbUFHPjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUFHPjc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 11:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbUFHPjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 11:39:31 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:24543 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265225AbUFHPja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 11:39:30 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jan Brezina <morf@atrey.karlin.mff.cuni.cz>
Subject: Re: DMA dosn't work on VIA vt8237 with >2.6.5
Date: Tue, 8 Jun 2004 17:43:15 +0200
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.58.0406080151220.32035@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.58.0406080151220.32035@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406081743.15869.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 of June 2004 11:37, Jan Brezina wrote:
> Hi,
> problem: DMA can not be enabled : hdparm : HDIO_SET_DMA ...
> I have tried kernels 2.6.6, 2.6.7-rc2 and 2.6.5, with various
> configurations, dosn't matter ...
> Kernel 2.6.1 works (but there some problem with vsftp and it isn't
> reported in 2.6.6 version) with probably right configuration (down).
> It seems that chipset driver can not take control over ide:
>
> VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.0
> VP_IDE: port 0x01f0 already claimed by ide0
> VP_IDE: port 0x0170 already claimed by ide1
> VP_IDE: neither IDE port enabled (BIOS)

http://www.uwsg.iu.edu/hypermail/linux/kernel/0403.2/0538.html

