Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264341AbTKUJHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 04:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTKUJHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 04:07:21 -0500
Received: from tssg.wit.ie ([193.1.185.11]:48266 "EHLO mail.tssg.org")
	by vger.kernel.org with ESMTP id S264341AbTKUJHU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 04:07:20 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Steven Davy <sdavy@tssg.org>
Reply-To: sdavy@tssg.org
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IPsec AH failure over IPv6
Date: Fri, 21 Nov 2003 09:09:51 +0000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200311210909.51836.sdavy@tssg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Im running performance tests using netperf (patched for ip6) across two 
machines, ESP works great but AH works really bad, practally all the packets 
are droped. Tcpdump reads the packets but they are not passed on to netperf. 
Read somewhere the IPsec Ah doesent like fragmentation over tcp, but im not 
sure. Im using manual keying, and the 2.5.75 kernel. Is there a kernel patch 
to fix this!!


regards
steven

TSSG WIT Waterford

