Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUGMAIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUGMAIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUGMAIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:08:50 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:25993 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S264396AbUGMAIp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:08:45 -0400
Subject: DBT2-MySQL Benchmark.   "hugemem" vs "smp" kernels
From: Peter Zaitsev <peter@mysql.com>
To: linux-kernel@vger.kernel.org
Cc: alexeyk@mysql.com
Content-Type: text/plain
Organization: MySQL
Message-Id: <1089677229.15336.693.camel@abyss.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 12 Jul 2004 17:07:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some half a year ago I wrote about my experience of performance of
"hugemem" vs "sm" kernels for 2.4.21-9.EL kernel from RH AS 3.0

The results I got previously were 

                 smp          hugemem 
IO BOUND:      1450TPM        1250TPM
CPU BOUND:     7000TPM        4500TPM


Results are in Transactions per Minute.

This was significant regression and it was some kind of expected.

The results with newer kernel 2.4.21-15.EL  are very strange however:


                 smp          hugemem 
IO BOUND:      1150TPM        1650TPM
CPU BOUND:     6300TPM        5000TPM


Well I'm pretty happy to see "hugemem" kernel improved a lot, but 
what happened with SMP kernel ? Why it is slow now for IO bound case 
and why it became slower than 2.4.21-9.EL ? 




I'm using 4*Pentium Xeon 2.0Ghz w HT,  4GB RAM,  3WARE RAID10, EXT3


-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



