Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315421AbSEBVGq>; Thu, 2 May 2002 17:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315422AbSEBVGp>; Thu, 2 May 2002 17:06:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54544 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315421AbSEBVGp>; Thu, 2 May 2002 17:06:45 -0400
Subject: Re: 2.4.19pres and IDE DMA
To: sflory@rackable.com (Samuel Flory)
Date: Thu, 2 May 2002 22:25:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <3CD1A469.9040605@rackable.com> from "Samuel Flory" at May 02, 2002 01:41:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173O5B-0004tW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I'm having issues with a Tyan 2720 and post 2.4.18 boards with a 
> Maxtor 4G120J6.  Under 2.4.18 I can turn on dma via "hdparm -d 1". 
>  Under 2.4.19pre7 I get "HDIO_SET_DMA fail ed: Operation not permitted". 

The BIOS fails to assign the resources

> PS-There is also some issue with a resource conflict that occurs under 
> every kernel I've tried.

Yep. Your BIOS didnt assign them.
