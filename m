Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbTKJWdT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 17:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTKJWdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 17:33:18 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:7072 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263262AbTKJWdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 17:33:17 -0500
Importance: Normal
Sensitivity: 
Subject: 2.6.0 kernel: Bind interrupt question.
To: linux-kernel@vger.kernel.org,
       "LTC interlock between development, performance, test, infrastructure,
	etc." <ltc-interlock@linux.ibm.com>
Cc: "LTC interlock between development, performance, test, infrastructure,
	etc." <ltc-interlock@linux.ibm.com>
From: Dong V Nguyen <dvnguyen@us.ibm.com>
Date: Mon, 10 Nov 2003 15:33:14 -0700
Message-ID: <OFEED7A2D8.B2402087-ON87256DDA.007B9132@us.ibm.com>
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 11/10/2003 15:33:15
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







Have you seen any problems with interrupt binding on 2.6.0-drv45003 ?
I tried this command to bind interrupt, but it does not work:
============================
cat  /proc/irq/165/smp_affinity
ffffffff00000000
echo 01 > /proc/irq/165/smp_affinity
cat  /proc/irq/165/smp_affinity
ffffffff00000000
===========================
There is nothing changed after binding.
One thing I see is it shows 16 digits "ffffffff00000000" on 2.6.0 while
only 8 digits in 2.4 .
Do I need any special ways to bind interrupt ?


Thanks.,




