Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSGVLhE>; Mon, 22 Jul 2002 07:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316840AbSGVLhE>; Mon, 22 Jul 2002 07:37:04 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:47869 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316838AbSGVLhD>; Mon, 22 Jul 2002 07:37:03 -0400
Subject: Re: [PATCH] Bluetooth Subsystem PC Card drivers for 2.5.27
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
       Maksim Krasnyanskiy <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0207212139150.3309-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0207212139150.3309-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 13:52:04 +0100
Message-Id: <1027342324.31782.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 04:39, Thunder from the hill wrote:
> Hi,
> 
> On 21 Jul 2002, Marcel Holtmann wrote:
> > this patch updates the PC Card drivers of the Bluetooth subsystem. It
> > modifies the following files: 
> 
> Please don't use EXPORT_NO_SYMBOLS where it's avoidable.

For 2.4 you want to use it whenever possible and a file exports no
symbols. For 2.5 EXPORT_NO_SYMBOLS is the automatic default behaviour so
you can lose the line

