Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131547AbRA3BLJ>; Mon, 29 Jan 2001 20:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131795AbRA3BK7>; Mon, 29 Jan 2001 20:10:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:56072 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131547AbRA3BKl>; Mon, 29 Jan 2001 20:10:41 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: DVD Disk Detection
Date: 29 Jan 2001 17:10:31 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9554a7$ncu$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0101291759200.6259-100000@penguin.linuxhardware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0101291759200.6259-100000@penguin.linuxhardware.org>
By author:    Kernel Related Emails <kernel@penguin.linuxhardware.org>
In newsgroup: linux.dev.kernel
>
> I was just wondering if anyone had any suggestions to check to see if a
> DVD is in a users DVD drive.  Currently if you run a CDROM_DISC_STATUS on
> a DVD you get a CDS_DATA_1 returned.  What kernel level call would
> destinguish between an actual Data CD and a DVD?
> 

Why does it matter?  Seriously, do you have any reason to act
differently between a CD and a small DVD, either of which contains a
UDF filesystem?  If not, don't.

Size, type of filesystem, etc, are obviously important -- but
shouldn't be determined by the type of the physical media.  It's
perfectly legitimate to have a large ISO 9660 filesystem on a DVD, or
an UDF filesystem on a CD.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
