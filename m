Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131738AbQLRNli>; Mon, 18 Dec 2000 08:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131717AbQLRNlS>; Mon, 18 Dec 2000 08:41:18 -0500
Received: from hera.cwi.nl ([192.16.191.1]:31138 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131271AbQLRNlH>;
	Mon, 18 Dec 2000 08:41:07 -0500
Date: Mon, 18 Dec 2000 14:10:32 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200012181310.OAA170929.aeb@aak.cwi.nl>
To: Andries.Brouwer@cwi.nl, mdharm-kernel@one-eyed-alien.net
Subject: Re: set_rtc_mmss: can't update from 0 to 59
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From mdharm@ziggy.one-eyed-alien.net Mon Dec 18 04:47:51 2000

    > so if your cmos time is 0.001 sec ahead of your system time
    > then around the hour you'll see
    >     set_rtc_mmss: can't update from 0 to 59

    but, the question is, how do we fix this?

Put #if 0 ... #endif around the printk.

Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
