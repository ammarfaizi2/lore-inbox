Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVAZNCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVAZNCW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 08:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVAZNCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 08:02:22 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:34729 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S262285AbVAZNCI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 08:02:08 -0500
X-Qmail-Scanner-Toxic-Mail-From: solt2@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Toxic-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner-Toxic: 1.24st (Clear:RC:1(213.238.96.250):. Processed in 0.269293 secs Process 30496)
Date: Wed, 26 Jan 2005 14:11:56 +0100
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0.1.33) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1755048250.20050126141156@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: How do I find out who uses swap?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem for some time with that the amount of swap
being used constantly increases up to the moment where
the swap is used in 100% and the machine deadlocks.

How do I find out which proceses use swap and in what amount?

I tried using top and sorting by SWAP, it shows this:
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  SWAP COMMAND
 3390 ncg       15   0 72504 3380 1720 S  0.0  0.7   0:00.76  67m ncgserver
24718 mysql     15   0 68056 7364 2232 S  0.0  1.4   2:30.70  59m mysqld
  582 fallen    16   0 30396  568  480 S  0.0  0.1   0:02.40  29m sc_serv
  624 vpopmail  16   0 31124 1736 1436 S  0.0  0.3   0:01.99  28m spamd
31765 solt      16   0 29916 1020  616 S  0.0  0.2   0:02.25  28m sc_serv
 3348 bind      22   0 31604 3872 1472 S  0.0  0.8   0:48.84  27m named
24021 root      16   0 32976  10m 7228 S  0.0  2.1   0:01.99  21m apache
13066 www-data  16   0 33104  10m 7276 S  0.0  2.2   0:00.62  21m apache
13103 www-data  16   0 33104  10m 7276 S  0.0  2.2   0:00.61  21m apache
13104 www-data  16   0 33104  10m 7276 S  0.0  2.2   0:00.60  21m apache
13099 www-data  16   0 33104  10m 7276 S  0.3  2.2   0:00.63  21m apache
13142 www-data  16   0 33104  10m 7276 S  0.0  2.2   0:00.61  21m apache
29898 www-data  16   0 33108  11m 7580 S  0.0  2.2   0:00.01  21m apache
13061 www-data  16   0 34492  12m 7700 S  0.0  2.5   0:00.56  21m apache
13057 www-data  15   0 35076  13m 7696 S  0.0  2.6   0:00.78  21m apache
23259 www-data  16   0 36344  14m 7784 S  0.0  2.9   0:01.15  21m apache
13062 www-data  15   0 37812  15m 7868 S  0.0  3.2   0:01.03  20m apache

Or should I look at VIRT or MEM ?
I am confused.

Regards,
Maciej


