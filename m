Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267321AbTAMOXo>; Mon, 13 Jan 2003 09:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267892AbTAMOXo>; Mon, 13 Jan 2003 09:23:44 -0500
Received: from zamok.crans.org ([138.231.136.6]:63432 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S267321AbTAMOXj>;
	Mon, 13 Jan 2003 09:23:39 -0500
Message-Id: <1903899.i9iqKqhZsQ@adelaide.crans.org>
From: Bertrand VIEILLE =?ISO-8859-15?Q?=5BB=E9bert=5D?= 
	<Bertrand.Vieille@crans.org>
Subject: Re: Linux 2.4.21pre3-ac2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Date: Mon, 13 Jan 2003 15:32:29 +0100
References: <20030113034016$67b9@gated-at.bofh.it> <20030113142009$6327@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Guess #1 is reverting mm/shmem.c.
> Guess #2 is reverting the buffer cache changes.
> Guess #3 is new IDE + highmem

I Have HighMem (1GB) so I can't help you here but "Khormy", in another
thread, said he has the problem with only 256MB so I don't think he uses
Highmem.

> Guess #4 is quota related (are people seeing the problem with
> quota disabled ?)

I don't have quota enabled, and I have lots of oopses with 2.4.21-pre3-ac1/3

The kernel 2.4.21-pre3 works fine on my box, so I think it's really related
to -ac patches.

-- 
Bertrand Vieille
