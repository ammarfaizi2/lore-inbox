Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130130AbRAIWVT>; Tue, 9 Jan 2001 17:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131615AbRAIWVJ>; Tue, 9 Jan 2001 17:21:09 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3463 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130130AbRAIWVA>;
	Tue, 9 Jan 2001 17:21:00 -0500
Date: Tue, 9 Jan 2001 14:03:47 -0800
Message-Id: <200101092203.OAA05934@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: goemon@anime.net
CC: mingo@elte.hu, stephenl@zeus.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101091110330.2908-100000@anime.net> (message from
	Dan Hollis on Tue, 9 Jan 2001 11:14:05 -0800 (PST))
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.30.0101091110330.2908-100000@anime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Tue, 9 Jan 2001 11:14:05 -0800 (PST)
   From: Dan Hollis <goemon@anime.net>

   Just extend sendfile to allow any fd to any fd. sendfile already
   does file->socket and file->file. It only needs to be extended to
   do socket->file.

This is not what senfile() does, it sends (to a network socket) a
file (from the page cache), nothing more.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
