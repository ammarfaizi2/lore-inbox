Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbTBJJxb>; Mon, 10 Feb 2003 04:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbTBJJxb>; Mon, 10 Feb 2003 04:53:31 -0500
Received: from denise.shiny.it ([194.20.232.1]:65427 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S264836AbTBJJxb>;
	Mon, 10 Feb 2003 04:53:31 -0500
Message-ID: <XFMail.20030210110310.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.50L.0302100127250.12742-100000@imladris.surriel.com>
Date: Mon, 10 Feb 2003 11:03:10 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.
Cc: lkml <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In the time of one disk seek plus half rotational latency
> (12 ms) you can do a pretty large amount of reading (>400kB).
> This means that for near and medium disk seeks you don't care
> all that much about how large the submitted IO is. Track buffers
> further reduce this importance.

This isn't always true. Removable devices usually have a quite
low seek time compared to their raw transfer rate.


Bye.

