Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVCZRcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVCZRcT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 12:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVCZRcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 12:32:19 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:56213 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261190AbVCZRcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 12:32:16 -0500
In-Reply-To: <1111850358.8042.34.camel@laptopd505.fenrus.org>
References: <200503261701.08774.chunkeey@web.de> <1111850358.8042.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bf8a98cafc4141c67d3b4cabfde65ed2@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Chuck <chunkeey@web.de>
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: How's the nforce4 support in Linux?
Date: Sat, 26 Mar 2005 18:32:04 +0100
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-03-26, at 16:19, Arjan van de Ven wrote:

> `
>> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>> hda: dma_intr: error=0x84 { DriveStatusError BadCRC
>
> BadCRC is 99% sure a cabling issue; either a bad/overheated cable or a
> cable used at too high a speed for the cable.

No. It is more likely that the timing programming between the disk and 
host controller
are in a miss-match state. UDMA mode detection can come in to mind too.
It makes sense to experiment with hdparm to see if the problem goes 
away in non
Ultra DMA modes.

