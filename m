Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVDDIe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVDDIe2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVDDIe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:34:28 -0400
Received: from box3.punkt.pl ([217.8.180.76]:18957 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261174AbVDDIeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:34:18 -0400
Message-ID: <4250FD08.1020509@punkt.pl>
Date: Mon, 04 Apr 2005 10:38:32 +0200
From: |TEcHNO| <techno@punkt.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041122
X-Accept-Language: en-gb, en-us, en-ca, en-au, ja, pl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [SCSI] Driver broken in 2.6.x?
References: <424EB65A.8010600@punkt.pl> <Pine.LNX.4.62.0504022301430.2525@dragon.hyggekrogen.localhost> <424F0BFF.6020402@punkt.pl> <Pine.LNX.4.62.0504022322150.2525@dragon.hyggekrogen.localhost> <42502EB2.3080802@punkt.pl> <20050403235726.GE3953@stusta.de>
In-Reply-To: <20050403235726.GE3953@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>As told, I tested it w/o nvidia module loaded, here's what I found:
>>1. It now doesn't hang on scanning for devices.
>>2. It now hangs on acquiring preview, logs will follow.
>>...
>>Apr  3 15:54:27 techno kernel: Unable to handle kernel NULL pointer
>>dereference at virtual address 0000014c
>>Apr  3 15:54:27 techno kernel:  printing eip:
>>Apr  3 15:54:27 techno kernel: c03d8143
>>Apr  3 15:54:27 techno kernel: *pde = 00000000
>>Apr  3 15:54:27 techno kernel: Oops: 0000 [#1]
>>Apr  3 15:54:27 techno kernel: PREEMPT
>>Apr  3 15:54:27 techno kernel: Modules linked in: nvidia
>>...

> Still with nvidia.
> 
> An Oops with the nvidia module loaded since the last boot is simply not 
> debuggable for anyone except nvidia.
Em, there's also the same (w/o oops) with out that module, each of that 
situations was separated by a reset. It was working well in 2.4.x so I 
guess it'a a problem with the card's (00:0c.0 SCSI storage controller: 
DTC Technology Corp. Domex 536) driver.

-- 
pozdrawiam     |"Help me master, I felt the burning twilight behind
techno@punkt.pl|those gates of stell..." --Perihelion, Prophecy Sequence
