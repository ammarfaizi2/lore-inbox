Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRBMAij>; Mon, 12 Feb 2001 19:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129160AbRBMAi3>; Mon, 12 Feb 2001 19:38:29 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:26124 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129159AbRBMAiT>; Mon, 12 Feb 2001 19:38:19 -0500
Date: Tue, 13 Feb 2001 00:38:16 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <linux-kernel@vger.kernel.org>
Subject: SO_RCVTIMEO, SO_SNDTIMEO
Message-ID: <Pine.LNX.4.30.0102130035550.9858-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I notice the entities in the subject line have appeared in Linux 2.4.

What is their functional specification? I guess they trigger if no bytes
are received/send within a consecutive period. How does the app get the
error? -EPIPE for a blocking read/write? If so, does SIGPIPE
get raised? Or is -ETIMEDOUT used? ...

TIA,
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
