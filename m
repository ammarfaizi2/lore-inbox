Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQKTUfJ>; Mon, 20 Nov 2000 15:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129309AbQKTUe7>; Mon, 20 Nov 2000 15:34:59 -0500
Received: from 213-123-73-80.btconnect.com ([213.123.73.80]:42501 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129213AbQKTUew>;
	Mon, 20 Nov 2000 15:34:52 -0500
Date: Mon, 20 Nov 2000 20:06:41 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11 ext2 filesystem corruptions
Message-ID: <Pine.LNX.4.21.0011202003080.1238-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just got a severe ext2 filesystem corruption again (something from
ext2_free_blocks about freeing blocks not in datazone and then in system
zones and also allocating block in system zone). Previously (last week) it
happened on a 4cpu machine. Today on 2cpu. All UP machines running latest
kernel were perfectly stable (wrt to this particular bug).

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
