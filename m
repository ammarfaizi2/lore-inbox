Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbTIPDGz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 23:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbTIPDGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 23:06:51 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:51840 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261779AbTIPDGe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 23:06:34 -0400
Message-ID: <1063681587.3f667e337da1c@dubai.stillhq.com>
Date: Tue, 16 Sep 2003 13:06:27 +1000
From: Michael Still <mikal@stillhq.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 Patch] Kernel-doc updates 11 of 15 -- /include/linux/skbuff.h
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 203.17.68.210
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes kernel-doc errors reported whilst doing
a make mandocs on 2.6-test4-bk5

Linus, please apply.

Cheers,
Mikal


--------------------------


diff -Nur linux-2.6.0-test4-bk5-mandocs/include/linux/skbuff.h
linux-2.6.0-test4-bk5-mandocs_tweaks/include/linux/skbuff.h
--- linux-2.6.0-test4-bk5-mandocs/include/linux/skbuff.h	2003-09-04
10:56:53.000000000 +1000
+++ linux-2.6.0-test4-bk5-mandocs_tweaks/include/linux/skbuff.h	2003-09-09
10:11:20.000000000 +1000
@@ -152,6 +152,7 @@
  *	@sk: Socket we are owned by
  *	@stamp: Time we arrived
  *	@dev: Device we arrived on/are leaving by
+ *      @real_dev: The real device we are using
  *	@h: Transport layer header
  *	@nh: Network layer header
  *	@mac: Link layer header
@@ -179,6 +180,7 @@
  *	@nfct: Associated connection, if any
  *	@nf_debug: Netfilter debugging
  *	@nf_bridge: Saved data about a bridged frame - see br_netfilter.c
+ *      @private: Data which is private to the HIPPI implementation
  *	@tc_index: Traffic control index
  */
 

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
