Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288540AbSAHWoI>; Tue, 8 Jan 2002 17:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288532AbSAHWn5>; Tue, 8 Jan 2002 17:43:57 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43256 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S288528AbSAHWnm>;
	Tue, 8 Jan 2002 17:43:42 -0500
Subject: Re:O(1) scheduler, 2.4.17-D2.patch,  some results
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFAB229BAA.8F0F11D3-ON85256B3B.007BFDD5@raleigh.ibm.com>
From: "Partha Narayanan" <partha@us.ibm.com>
Date: Tue, 8 Jan 2002 16:43:35 -0600
X-MIMETrack: Serialize by Router on D04NMS38/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 01/08/2002 05:43:36 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VolanoMark 10/100 Loopback test results:

8-way 700 Mhz.
Kernel built with 1GB Memory support,
IBM JVM 1.3 (build cx130-20010626)
Throughput in msg/sec



     2.4.14         2.4.14 + MQ    2.4.17          2.4.17+ Ingo's scheduler
     ==============================================================

4-way     17565          24864           15894          23300

8-way     13734          37007           11595          29726


2.4.14 performs better than 2.4.17 - run queue lock added to sched_yield in
2.4.17.
The new scheduler will be analyzed further and the results posted.


Please respond to partha@us.ibm.com.

Partha

