Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291916AbSBTPHy>; Wed, 20 Feb 2002 10:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291903AbSBTPHo>; Wed, 20 Feb 2002 10:07:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11785 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291900AbSBTPHa>; Wed, 20 Feb 2002 10:07:30 -0500
Subject: Re: Adaptec dpt_i20.c broken in 2.5?
To: ledzep37@attbi.com (Jordan Breeding)
Date: Wed, 20 Feb 2002 15:21:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C738AA0.AC31A1BB@attbi.com> from "Jordan Breeding" at Feb 20, 2002 05:38:08 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dYZ5-0003pU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> dpt_i2o Adaptec driver.  However, currently in 2.5.5 if you select
> Adaptec i2o to be compiled it gives an error caused by this line:
> 
> #error Please convert me to Documentation/DMA-mapping.txt
> 
> Will this be fixed in a -pre version any time soon?  Thanks for any info
> on the situation with this scsi driver.

It depends when someone fixes it. The 2.4 one is fine, but for 2.5 you or
someone else need to adapt it to the new pci dma interfaces.
