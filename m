Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268576AbTBYVgv>; Tue, 25 Feb 2003 16:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268577AbTBYVgv>; Tue, 25 Feb 2003 16:36:51 -0500
Received: from dsl-fl-207-34-65-6-cgy.nucleus.com ([207.34.65.6]:45489 "EHLO
	bluetooth.WNI.AD") by vger.kernel.org with ESMTP id <S268576AbTBYVgt>;
	Tue, 25 Feb 2003 16:36:49 -0500
Message-ID: <3E5BE54E.50705@WirelessNetworksInc.com>
Date: Tue, 25 Feb 2003 14:51:10 -0700
From: Herman Oosthuysen <Herman@WirelessNetworksInc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Writing new filesystem
References: <20030225083631.17493.qmail@webmail17.rediffmail.com> <20030225111428.A1666@hexapodia.org>
In-Reply-To: <20030225111428.A1666@hexapodia.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 21:47:04.0740 (UTC) FILETIME=[6FAD2640:01C2DD17]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  [snip]
> 
> Look at fs/Makefile, search for "ext2", and add your new fs directory in
> the appropriate spots.
> 
> I would recommend using ext2 or something, rather than msdosfs, as your
> template.  The DOS filesystem is crufty.
> 
> -andy
> 

I agree with above.  Also, first look at the simplest fs, which is 
romfs.  Then look at the oldest, which is minix and finally look at 
ext2.  After that exercise, you'll know how it works.

