Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUIJLPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUIJLPU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 07:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUIJLPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 07:15:19 -0400
Received: from wip-ec-wd.wipro.com ([203.101.113.39]:59525 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP id S267234AbUIJLPQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 07:15:16 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: question on fs/read_write.c modification from 2.6.7 to 2.6.8.1
Date: Fri, 10 Sep 2004 16:45:10 +0530
Message-ID: <93AC2F9171509C4C9CFC01009A820FA00177D801@blr-ec-msg05.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question on fs/read_write.c modification from 2.6.7 to 2.6.8.1
Thread-Index: AcSXJgK3jxnlm6+KSVSWoV8SxFcJ/gAAS0tQ
From: <manjunathg.kondaiah@wipro.com>
To: <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Sep 2004 11:15:10.0584 (UTC) FILETIME=[6FA54F80:01C49727]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
Thanks for the clarifications. Just one more set of clarifications:
>It doesn't prevent such use but it makes the default behaviour
>for a driver correct so makes it easier to write drivers correctly
1. Is the performance penalty we pay for every read and write worth
this? I assume it does.
2. Would it provide better enforcement if the file structure is also a
copied when passed to drivers? A kind of encapsulation...
Regards,
Manjunath

