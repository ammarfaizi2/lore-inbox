Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266034AbRGGFpO>; Sat, 7 Jul 2001 01:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266035AbRGGFpE>; Sat, 7 Jul 2001 01:45:04 -0400
Received: from [203.199.75.248] ([203.199.75.248]:16705 "EHLO indiainfo.com")
	by vger.kernel.org with ESMTP id <S266034AbRGGFpB>;
	Sat, 7 Jul 2001 01:45:01 -0400
From: "gopi krishna" <mgopi@indiainfo.com>
Subject: device plugging
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.4.7
Date: Sat, 07 Jul 2001 11:10:43 +0530
Message-ID: <web-26606962@indiainfo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why do we need a dummy req for plugging.
As i understood only thing plugging does is to, on arrival of new req if
the dev queue is empty, puts a dummy req on the queue, and schedules the
unplug routine on tq_disk, which on being scheduled calls the strategy
routine.
So we can as well put the new req on the queue without dummy req.

If i'm incorrect please explain what's exact process and the reason

Please cc the response to mgopi@indiainfo.com as i'm not subscribed.

thanks
----------------------------------------
http://mail.indiainfo.com
First you had 10MB of free mail space.
Now you can send mails in your own language !!!
