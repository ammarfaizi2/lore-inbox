Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265242AbUBEPOQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 10:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUBEPOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 10:14:16 -0500
Received: from news.cistron.nl ([62.216.30.38]:4797 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S265242AbUBEPOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 10:14:15 -0500
From: Joost Witteveen <joostje@foko.komputilo.org>
Subject: Re: DMA BadCRC, cables exchanged, problem resists, any idea?
Date: Thu, 5 Feb 2004 15:14:14 +0000 (UTC)
Organization: Cistron
Message-ID: <slrnc24ne6.1nu.joostje@foko.komputilo.org>
References: <20040204211338.GA31768@x20.informatik.uni-bremen.de>
X-Trace: ncc1701.cistron.net 1075994054 2977 62.216.19.202 (5 Feb 2004 15:14:14 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040204211338.GA31768@x20.informatik.uni-bremen.de>, Sven Schumacher wrote:
> Hello,
> 
> I got the following error for 3 of my 4 harddrives:
> 
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }

Looks like the problem mentioned in

http://www.ussg.iu.edu/hypermail/linux/kernel/0401.2/0111.html

Looks not very bad (and I hope it is, as I'm getting the same
lines in /var/log/messages) 

Thanks
joostje

