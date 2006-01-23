Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWAWGqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWAWGqe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 01:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWAWGqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 01:46:34 -0500
Received: from sccrmhc12.comcast.net ([63.240.77.82]:18628 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964846AbWAWGqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 01:46:33 -0500
Date: Mon, 23 Jan 2006 01:46:13 -0500 (EST)
From: Ariel <askernel2615@dsgml.com>
To: Chase Venters <chase.venters@clientec.com>
cc: Arjan van de Ven <arjan@infradead.org>,
       Jamie Heilman <jamie@audible.transient.net>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
In-Reply-To: <200601230029.12674.chase.venters@clientec.com>
Message-ID: <Pine.LNX.4.62.0601230136080.22979@pureeloreel.qftzy.pbz>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz>
 <Pine.LNX.4.62.0601222045180.12815@pureeloreel.qftzy.pbz>
 <1137997104.2977.7.camel@laptopd505.fenrus.org> <200601230029.12674.chase.venters@clientec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Jan 2006, Chase Venters wrote:

> On Monday 23 January 2006 00:17, Arjan van de Ven wrote:
>>> A commonality I'm noticing is SATA. SATA had a big update in this
>>> version, so perhaps that's where to start looking.
>>
>> I wonder if it can be narrowed even more, like to the exact chipset
>> driver?
>
> Anton and I use an Intel 82801 (ICH6). Ariel's dmesg doesn't look like an ICH6
> to me at first glance, but he's also on ata_piix.

I'm on ICH5, but also Sil3112 and HighPoint 372N.

Jamie has ICH6 and Sil3112.

ata_piix seems like it's in common for all, but this is not a lot of 
systems, so it could just be a coincidence and the problem caused by 
something that's not chipset specific.

 	-Ariel
