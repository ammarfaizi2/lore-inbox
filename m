Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbRGBMyW>; Mon, 2 Jul 2001 08:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264526AbRGBMyN>; Mon, 2 Jul 2001 08:54:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64776 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264818AbRGBMx4>; Mon, 2 Jul 2001 08:53:56 -0400
Subject: Re: linux-2.4.6-pre8/drivers/mtd/nand/spia.c: undefined symbols
To: sjhill@cotw.com
Date: Mon, 2 Jul 2001 13:52:46 +0100 (BST)
Cc: adam@yggdrasil.com (Adam J. Richter), dwmw2@redhat.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <3B406B63.4E28CA8A@cotw.com> from "Steven J. Hill" at Jul 02, 2001 07:38:59 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15H3C2-0005qS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The way that I architected the raw NAND flash device driver was to
> break it into 2 parts. 'nand.c' contains the actual driver code and
> is considered to be device independent. 'spia.c' is the device
> dependent part. You should write your own version of 'spia.c' and

So the Config.in is wrong since I can select spia on x86

