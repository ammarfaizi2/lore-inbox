Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135372AbRARTuG>; Thu, 18 Jan 2001 14:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135313AbRARTtq>; Thu, 18 Jan 2001 14:49:46 -0500
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:17674 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S132643AbRARTtj>; Thu, 18 Jan 2001 14:49:39 -0500
Date: Thu, 18 Jan 2001 19:49:36 +0000 (GMT)
From: Tim Fletcher <tim@parrswood.manchester.sch.uk>
To: David Balazic <david.balazic@uni-mb.si>
cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
        Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <3A672015.B69F7E90@uni-mb.si>
Message-ID: <Pine.LNX.4.30.0101181944280.7321-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is the difference between physical and logical partitions ?

primary (what you call physical) partitions are partitions in their own
right logical partitions are partitions within a special partition

> How does this solve the "I deleted hda5 and now the old hda6 became
> hda5" problem ?

It doesn't nothing can as the way that the pcbios extended partition works
as a (linked?) list of partitions so removing one shuffles the rest up.

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
 irc: Night-Shade on quakenet      ^^-^^

"While preceding your entrance with a grenade is a good tactic in
   Quake, it can lead to problems if attempted at work." -- C Hacking

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
