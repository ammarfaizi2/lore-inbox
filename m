Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129157AbQKNOt0>; Tue, 14 Nov 2000 09:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbQKNOtQ>; Tue, 14 Nov 2000 09:49:16 -0500
Received: from windsormachine.com ([206.48.122.28]:47109 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S129340AbQKNOtJ>; Tue, 14 Nov 2000 09:49:09 -0500
Message-ID: <3A1149CD.A2A1E4F4@windsormachine.com>
Date: Tue, 14 Nov 2000 09:18:53 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: LA Walsh <law@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE0 /dev/hda performance hit in 2217 on my HW
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIEJDCJAA.law@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check if DMA mode is still on, on your hard drive.  I'm trying to remember if
that behaviour changed for 2.2.17

LA Walsh wrote:

> I skimmed over the archives and didn't find a mention of this.  I thought
> I'd noticed this when I first installed 2217, but I was too busy to verify
> it at the time.
>
> Simple case:
> Under 2216, I can do a 'badblocks /dev/hda1 XXXXX'.  Vmstat shows about
> 10,000K/s average.  This is consistent with 'dd' operations I use to copy
> partitions for disk mirroring/backup.
>
> Under 2217, the xfer speed drops to near 1,000K/s.  This is for both
> 'badblocks'
> and a 'dd' if=/dev/hda of=/dev/hdb bs=256k.  In both instances, I notice
> a near 90% performance degredation.
>
> Haven't tried any latest 2.2.18's -- has there been any work that might
> have fixed this problem in 2218.  Am I the only person who noticed this?
> I.e. -- maybe it's something peculiar to my HW (Inspiron 7500),
> IBM DARA-22.5G HD.
>
> --
> L A Walsh                        | Trust Technology, Core Linux, SGI
> law@sgi.com                      | Voice/Vmail: (650) 933-5338
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
