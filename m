Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315805AbSHBQJQ>; Fri, 2 Aug 2002 12:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSHBQI2>; Fri, 2 Aug 2002 12:08:28 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32018
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315456AbSHBQHY>; Fri, 2 Aug 2002 12:07:24 -0400
Date: Fri, 2 Aug 2002 09:04:03 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Ed Tomlinson <tomlins@cam.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.30 ide problems booting 
In-Reply-To: <200208020726.51659.tomlins@cam.org>
Message-ID: <Pine.LNX.4.10.10208020838420.32582-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2002, Ed Tomlinson wrote:

> reiserfs: checking transaction log (ide2(33,3)) for (ide2(33,3))
> hde: dma_intr: bad DMA status (dma_stat=36)
> hde: ide_dma_intr: status=0x50 [ drive ready,seek complete] 
> hde: request error, nr. 1

How the heck did you get get bit 4 of the dma_status register to report
anything other than "0" ??

Next "HTH", did it manage to invoke an DMA Error and Interrupt and return
a the drive back in to command mode with a 50 stat ?

I have never been so amazed by this driver's ablity to invoke hardware
events that can not happen.



Andre Hedrick
LAD Storage Consulting Group

