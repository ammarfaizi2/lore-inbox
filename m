Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316678AbSE0QaI>; Mon, 27 May 2002 12:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316679AbSE0QaH>; Mon, 27 May 2002 12:30:07 -0400
Received: from mx6.mail.ru ([194.67.57.16]:26117 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id <S316678AbSE0QaG>;
	Mon, 27 May 2002 12:30:06 -0400
From: "Muthal Sangam" <sangam@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: interrupt latency/700microsecs
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 144.16.67.155 via proxy [144.16.67.8]
Date: Mon, 27 May 2002 20:30:06 +0400
Reply-To: "Muthal Sangam" <sangam@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E17CNNm-000GQe-00@f11.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On kernel 2.4.7, AMDK6 @ 450MHz processor, is it possible to get latency
fluctuations of upto 700microsecs for running the timer interrupt, due to
interrupts being disabled ?

I am using the time stamp counter and reading it at the start of the timer
interrupt and measuring the cycles elapsed between two inovocations of it.
The number of cycles elapsed is ~4500225, but sometimes it increases to as
high as 4848032. Can i conclude that this difference is due to interrupts
being disabled in critical sections ? ( I think i am making some mistake :-)

- sangam

