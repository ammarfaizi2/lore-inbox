Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273977AbRIXQHQ>; Mon, 24 Sep 2001 12:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273976AbRIXQHG>; Mon, 24 Sep 2001 12:07:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273978AbRIXQG4>; Mon, 24 Sep 2001 12:06:56 -0400
Subject: Re: Linux-2.4.10 - necessary patches
To: smcameron@yahoo.com (Stephen Cameron)
Date: Mon, 24 Sep 2001 17:12:29 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010924155654.89241.qmail@web12304.mail.yahoo.com> from "Stephen Cameron" at Sep 24, 2001 08:56:54 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lYLN-00030e-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it help to move these into a cpqfc specific header file? I'm
> making changes to cpqfc already anyway (to use new DMA interfaces) so
> I oculd move those ioctls while I was at it.

Probably a good idea for the moment. The problem is those ioctl values
might get issued for something else. Really we need a 'device private'
range for scsi ioctls or something
