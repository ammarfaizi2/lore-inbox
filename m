Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263169AbRE1V0B>; Mon, 28 May 2001 17:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263170AbRE1VZv>; Mon, 28 May 2001 17:25:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23301 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263169AbRE1VZn>; Mon, 28 May 2001 17:25:43 -0400
Subject: Re: Creative 4-speed CDROM driver
To: james@spunkysoftware.com
Date: Mon, 28 May 2001 22:22:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <016601c0e7f7$0c7c8780$c1a5fea9@spunky> from "james@spunkysoftware.com" at May 29, 2001 05:22:55 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154UTa-0003YH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If anyone on the kernel list has written a driver for a CDROM please send me
> mail about how you went about it, did you approach the manufacturer for the
> documentation on the device, if I made a mistake could I ruin my hardware?
> and stuff like that.

For IDE CD-ROM there is a standard. Its about 600 pages long but the best
model is probably to implement scsi over atapi since Minix has some basic scsi
code. Then you can drive all but very old ide cdrom devices as scsi

