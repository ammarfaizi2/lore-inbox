Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbRAPJhG>; Tue, 16 Jan 2001 04:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129725AbRAPJg5>; Tue, 16 Jan 2001 04:36:57 -0500
Received: from [202.158.36.82] ([202.158.36.82]:56571 "EHLO
	asmuni.trustix.co.id") by vger.kernel.org with ESMTP
	id <S129604AbRAPJgr>; Tue, 16 Jan 2001 04:36:47 -0500
Date: Tue, 16 Jan 2001 16:35:11 +0700 (JAVT)
From: <imel96@trustix.co.id>
To: <Andries.Brouwer@cwi.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] plan9 partition support
In-Reply-To: <UTC200101140126.CAA114484.aeb@ark.cwi.nl>
Message-ID: <Pine.LNX.4.30.0101161628260.20940-100000@asmuni.trustix.co.id>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



	hi,

	i read the man page more carefully, it says
	that the partition table is really just a
	textual partition table. the __u32 came
	from bsd partition table code i copied.

	i also fixed the doc. the 9fat always has
	the same starting sector number with the
	plan9 partition table, only plan9 put its
	information in the 2nd sector.


On Sun, 14 Jan 2001 Andries.Brouwer@cwi.nl wrote:
> I'll have a look.
> A week ago you sent almost the same patch.
> Was there a reason to change __u32 into unsigned long?


		imel


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
