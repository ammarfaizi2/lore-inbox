Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTFOGOL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 02:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTFOGOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 02:14:11 -0400
Received: from venus.uos.ac.kr ([210.125.183.202]:25026 "EHLO venus.uos.ac.kr")
	by vger.kernel.org with ESMTP id S261936AbTFOGOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 02:14:10 -0400
From: "Youngmin Kim" <blhole@venus.uos.ac.kr>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Where or when are L2(ethernet) src/dst addresses changed during forwarding or local-out?
Date: Sun, 15 Jun 2003 15:27:58 +0900
Message-ID: <001401c33307$43afacc0$1e6ef9cb@LocalHost>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where or when are L2(ethernet) src/dst addresses changed during
forwarding or local-out?

In linux kernel about network, Which functions and forwarding phases
are
related above?



forwarding phase : 

1. 
packet --> NF_IP6_PRE_ROUTE --> decision of forwarding or local in
--> (if forwarding) NF_IP6_FORWARD --> NF_IP6POST_ROUTING
2. 
packet --> NF_IP6_LOCAL_OUT --> routing --> NF_IP6_POST_ROUTING


Thank you!!

