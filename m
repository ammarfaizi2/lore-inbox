Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312582AbSELLYl>; Sun, 12 May 2002 07:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSELLYk>; Sun, 12 May 2002 07:24:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59912 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312582AbSELLYj>; Sun, 12 May 2002 07:24:39 -0400
Subject: Re: IRQ > 15 for Athlon SMP boards
To: hugh@nospam.com (Hugh)
Date: Sun, 12 May 2002 12:18:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CDE48CC.9050003@nospam.com> from "Hugh" at May 12, 2002 07:49:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E176rMX-0003Gu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Bus  1, device   5, function  0:
>     VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 4).
>       IRQ 16.

Looks fine to me. IRQ 0-15 limitations are the ancient world of ISA bus

> The results were the same.  The consequence is that X does not
> start because of an error that reads like
> 
> =============================================================
> (WW) MGA No matching device section for instance (BusID PCI:1:5:0) found
> (EE) No devices detected
> ==================================================================

I don't know why X is not running but I don't think the IRQ is related at
all
