Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282062AbRLBSw3>; Sun, 2 Dec 2001 13:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281827AbRLBSwU>; Sun, 2 Dec 2001 13:52:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39442 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281210AbRLBSwH>; Sun, 2 Dec 2001 13:52:07 -0500
Subject: Re: [PATCH] missing gendisk initialization in cpqarray.c (Linux-2.2.20)
To: andreas@xss.co.at (Andreas Haumer)
Date: Sun, 2 Dec 2001 19:00:12 +0000 (GMT)
Cc: arrays@compaq.com, linux-kernel@vger.kernel.org
In-Reply-To: <3C0A7020.C177BEA8@xss.co.at> from "Andreas Haumer" at Dec 02, 2001 07:17:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16AbqW-0004Bt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following patch adds code to initialize gendisk.fops
> in cpqarray.c. It's needed to avoid a kernel warning message
> when using devfs with the Compaq RAID Controller.
> 
> --- linux-2.2.20/drivers/block/cpqarray.c       Fri Nov  2 17:39:06
> 2001

Im confused. Linux 2.2 doesn't include devfs. This patch therefore seems
nonsense
