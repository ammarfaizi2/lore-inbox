Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbSBRTUT>; Mon, 18 Feb 2002 14:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291384AbSBRTRa>; Mon, 18 Feb 2002 14:17:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11015 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291289AbSBRTPz>; Mon, 18 Feb 2002 14:15:55 -0500
Subject: Re: 2.5.5-pre1 File size limit exceeded in fdisk on extended partitions
To: brak@waste.org (Brak)
Date: Mon, 18 Feb 2002 19:30:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202172317140.11770-100000@waste.org> from "Brak" at Feb 17, 2002 11:33:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ctUB-0006YA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After changing extended partition type on sda or sdb (1 Gig
> or 2 Gig partition) and attempting to write partition table, fdisk exits with File
> size limit exceeded error message.

Known problem. The 2.4 fixes for this are not yet in 2.5 for some reason.
Fdisk it and mkfs in 2.4 and it should fine mounted to play with in 2.5
