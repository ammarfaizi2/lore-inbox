Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286403AbSAVAEQ>; Mon, 21 Jan 2002 19:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289001AbSAVAEG>; Mon, 21 Jan 2002 19:04:06 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:61181 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S286403AbSAVADy>; Mon, 21 Jan 2002 19:03:54 -0500
Subject: Performance Results for Ingo's O(1)-scheduler
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF4544D2BC.16B7A12D-ON85256B48.00817250@raleigh.ibm.com>
From: "Partha Narayanan" <partha@us.ibm.com>
Date: Mon, 21 Jan 2002 18:03:50 -0600
X-MIMETrack: Serialize by Router on D04NMS38/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/21/2002 07:03:51 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some results from running VolanoMark on different
versions of O(1)-scheduler based on 2.4.17.

VolanoMark 2.1.2 Loopback test,
8-way 700MHZ Pentium III,
1GB Kernel,
IBM JVM 1.3. (build cx 130 -20010626)
Throughput in msg/sec


KERNEL              UP          4-way       8-way
=========           ======      ======      ======

2.4.17              11005       15894       11595

2.4.17 + D2 patch   10606       23300       29726

2.4.17 + G1 patch   10415       23038       31098

2.4.17 + H6 patch   10914       22270       32300

2.4.17 + H7 patch   11018       23427       31674

2.4.17 + J2 patch   13015       23071       33259




Partha Narayanan
partha@us.ibm.com

