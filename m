Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263117AbSJGPiK>; Mon, 7 Oct 2002 11:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263119AbSJGPiK>; Mon, 7 Oct 2002 11:38:10 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:40069 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S263117AbSJGPiI>;
	Mon, 7 Oct 2002 11:38:08 -0400
Message-ID: <3DA1ABA1.7080802@colorfullife.com>
Date: Mon, 07 Oct 2002 17:43:29 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: "Murray J. Root" <murrayr@brain.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.40-ac4  kernel BUG at slab.c:1477!
References: <Pine.LNX.4.10.10210061845320.23945-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
 >
> Only that if it is SG it must conform the ATA/ATAPI DMA on 64kb on 4b
> boundaries.
 >
What does that mean?

Is a 4 byte aligned buffer that doesn't cross a page boundary (4096 
byte) an acceptable buffer for the inquiry buffer of ide-scsi?

--
	Manfred

