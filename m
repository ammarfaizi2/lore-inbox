Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265935AbUBJSKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUBJSIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:08:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:2527 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265847AbUBJSET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:04:19 -0500
Date: Tue, 10 Feb 2004 10:04:16 -0800
From: cliff white <cliffw@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Recent Reaim results (STP)
Message-Id: <20040210100416.0ba5cf6d.cliffw@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There hasn't been much big change in reaim runs lately,
but just to show we're Not Dead Yet, I
did some quick graphs for some recent kernels:
( 2.6.3-rc2 vs 2.6.2-rc3-mm1 ) 


http://developer.osdl.org/cliffw/reaim/compares/index.html

All tests were run on ext3. System descriptions here:
http://www.osdl.org/stp

Noteworthy: 2.6.3-rc2 is a tiny,tiny,itsy bit slower than 2.6.2.

	   2.6.3-rc1-mm1 is 5.79 percent faster than 2.6.3-rc2 on the
	2-way compute run. This is new - usually the results of
	the compute test do not differ between mainline and -mm.

Numbers: 


1-way
Database load
Kernel                    JPM     Lusers Pct Change
patch-2.6.3-rc2           1001.21   17  0.00
2.6.2-rc3-mm1             982.31   17 -1.89
linux-2.6.2               1000.03   17 -0.12

Compute load
patch-2.6.3-rc2           1025.48   17  0.00
2.6.2-rc3-mm1             1006.36   17 -1.86
linux-2.6.2               1024.82   17 -0.06

Fileserver load
patch-2.6.3-rc2           3741.72   62  0.00
2.6.3-rc1-mm1             3712.67   62 -0.78
linux-2.6.2               3748.21   63  0.17

2-way
Database load
patch-2.6.3-rc2           1285.31   22  0.00
2.6.3-rc1-mm1             1321.30   22  2.80
linux-2.6.2               1297.90   22  0.98

Compute load
patch-2.6.3-rc2           1446.99   26  0.00
2.6.3-rc1-mm1             1530.82   26  5.79
linux-2.6.2               1455.38   26  0.58

Fileserver  load
patch-2.6.3-rc2           6190.24  104  0.00
2.6.3-rc1-mm1             6123.20  102 -1.08
linux-2.6.2               6173.62  104 -0.27

4-way
Database load
patch-2.6.3-rc2           5288.33   88  0.00
2.6.2-rc3-mm1             5293.70   88  0.10
linux-2.6.2               5246.54   88 -0.79

Compute
patch-2.6.3-rc2           5169.71   88  0.00
2.6.2-rc3-mm1             5159.36   88 -0.20
linux-2.6.2               5206.06   88  0.70

Fileserver load
patch-2.6.3-rc2           10343.18  172  0.00
2.6.2-rc3-mm1             10254.39  168 -0.86
linux-2.6.2               10351.30  176  0.08

8-way
Database load ( Deadline scheduler )
patch-2.6.3-rc1           8591.23   88  0.00
2.6.2-rc3-mm1             9082.65  144  5.72
linux-2.6.2               8565.25  128 -0.30

Compute load
patch-2.6.3-rc1           9640.14  160 -0.11
2.6.2-rc3-mm1             9645.81  160 -0.05
linux-2.6.2               9711.96  160  0.63

cliffw
OSDL
-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
