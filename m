Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268163AbTAKWil>; Sat, 11 Jan 2003 17:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268164AbTAKWil>; Sat, 11 Jan 2003 17:38:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:54688 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268163AbTAKWil> convert rfc822-to-8bit;
	Sat, 11 Jan 2003 17:38:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Morton <akpm@digeo.com>
To: Andre Hedrick <andre@linux-ide.org>, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [2.4 patch] update help for hpt366.c
Date: Sat, 11 Jan 2003 14:47:36 -0800
User-Agent: KMail/1.4.3
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10301111335480.11839-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10301111335480.11839-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301111447.36613.akpm@digeo.com>
X-OriginalArrivalTime: 11 Jan 2003 22:47:20.0757 (UTC) FILETIME=[6666CE50:01C2B9C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat January 11 2003 13:42, Andre Hedrick wrote:
>
> Caution!
>
> I and Andrew Morton have hpt374's which do not behave will under U133.
> It could be a device - controller combination erratium but not sure
>

Well that _used_ to be the case.  But I just retested - the hpt374 under
2.5.56 is writing at a smooth 35 megs/sec to a single disk using UDMA6.

So it looks like something got fixed - it used to write extremely slowly
unless I forced it back to UDMA5.


