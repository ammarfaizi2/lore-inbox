Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbTE3Obl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 10:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbTE3Obl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 10:31:41 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:63139 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263709AbTE3Obk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 10:31:40 -0400
Message-Id: <5.1.0.14.2.20030530164138.00aeee40@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 30 May 2003 16:44:55 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: drivers/char/sysrq.c
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/char/sysrq.c (2.4 and 2.5) we have :

         if ((key >= '0') & (key <= '9')) {
                 retval = key - '0';
         } else if ((key >= 'a') & (key <= 'z')) {

Shouldn't the "&" be (pedantically) "&&" ?

Margit 

