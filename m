Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbTDQENo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 00:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbTDQENn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 00:13:43 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:4062 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP id S262946AbTDQENm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 00:13:42 -0400
Date: Wed, 16 Apr 2003 21:25:34 -0700
From: Jeffrey Baker <jwbaker@acm.org>
Subject: Re: WimMark I report for 2.5.67-mm3
To: linux-kernel@vger.kernel.org
Cc: Joel.Becker@oracle.com
Message-id: <20030417042533.GA19325@noodles>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> WimMark I report for 2.5.67-mm3
> 
> Runs (deadline):  1778.54 1656.24 1487.90
> Runs (antic):  635.58 636.05 592.61

Historical perspective below.  2.5.67-mm3-deadline is the fastest
yet.  2.5.??-mm?-deadline are the fastest generally.  2.4 is not too
far back.

			WimMark			
Kernel		1	2	3	Mean
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2.5.64		1430.06	1194.90		1312.48
2.5.64-mm1-as	547.28	580.69		563.99
2.5.64-mm1-dl	1557.79	1360.52		1459.16
2.5.64-mm2-as	632.87	597.33	555.19	595.13
2.5.64-mm2-dl	1580.10	1537.95		1559.03
2.5.64-mm4-as	1066.70	1291.23		1178.97
2.5.64-mm4-dl	1655.77	1594.73	1610.91	1620.47
2.5.65-mm1-as	1559.32	1025.38	1579.98	1388.23
2.5.65-mm1-dl	1554.48	1589.89	1350.37	1498.25
2.5.65-mm2-as	1374.22	1487.19	1437.26	1432.89
2.5.65-mm2-dl	1238.58	1537.36	1513.04	1429.66
2.4.21-pre5	1565.87	1571.72	1521.43	1553.01
2.5.66		1580.45	1079.92	1325.82	1328.73
2.5.65-mm4-dl	1577.62	1596.15	1613.39	1595.72
2.5.65-mm4-as	997.99	1404.44	1177.43	1193.29
2.5.66-mm1-as	1119.58	735.69	879.24	911.50
2.5.66-mm1-dl	1221.11	1376.93	1532.29	1376.78
2.5.66-mm3-dl	1736.51	1681.50	1010.98	1476.33
2.5.66-mm3-as	579.62	496.75	517.06	531.14
2.5.67		1382.36	1392.28	1378.82	1384.49
2.5.67-mm3-dl	1778.54	1656.24	1487.90	1640.89
2.5.67-mm3-as	635.58	636.05	592.61	621.41

This benchmark interests me regarding my troubles with postgres and
mysql on 2.4.??-aa?.  Do you care to do more comparisons with 2.4
kernel trees?  How about with ext2 instead of ext3?  Isn't ext3 too
lock-happy for a 4-way machine?

-jwb
