Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131028AbRCTWKq>; Tue, 20 Mar 2001 17:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131056AbRCTWKg>; Tue, 20 Mar 2001 17:10:36 -0500
Received: from logger.gamma.ru ([194.186.254.23]:21004 "EHLO logger.gamma.ru")
	by vger.kernel.org with ESMTP id <S131028AbRCTWKa>;
	Tue, 20 Mar 2001 17:10:30 -0500
To: linux-kernel@vger.kernel.org
Path: pccross!not-for-mail
From: crosser@average.org (Eugene Crosser)
Newsgroups: linux.kernel
Subject: [2.4.2] APM unwanted wakeup from standby (kreiserfsd?)
Date: 21 Mar 2001 00:45:22 +0300
Organization: Average
Message-ID: <998j1i$hs5$1@pccross.average.org>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gentlemen,

this might be somewhat offtopic but I could not find answers on the Net
and "official" APM page seems dramatically out of date...

I recently bought Casio Fiva mini notebook that has APM BIOS 1.2,
Linux APM support partly works.  "Hibernate" does not work at all,
but let it be.  "Standby" ("apm -S") puts the box in standby mode
but after 10..30 seconds it inevitably awakes with a message like
"Normal resume from standby".  This happens even if there are no
processes that would initiate disk/screen/whatever activity (single
user mode).

My suspect is kreiserfsd.  If I am right, could it be modified to
honor standby mode and stop disk access?  If I am wrong, does
anyone have suggestions/advice/ideas how to make standby mode work?
(advice on making hibernate work is also welcome)

Eugene
