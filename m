Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTIYIaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 04:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTIYIaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 04:30:08 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:19672 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261774AbTIYI3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 04:29:24 -0400
X-KENId: 00003B2BKEN00A5A40F
X-KENRelayed: 00003B2BKEN00A5A40F@PCDR800
Date: Thu, 25 Sep 2003 10:22:56 +0200
From: "Christoph Baumann" <cb@sorcus.com>
Subject: Re: mysterious problem with IO memory
To: <linux-kernel@vger.kernel.org>
Reply-To: "Christoph Baumann" <cb@sorcus.com>
Message-Id: <002001c3833e$394c0440$2265a8c0@dirtyentw>
References: <004b01c3829e$4fe29980$2265a8c0@dirtyentw>
Mime-Version: 1.0
Content-Type: text/plain;
   charset="iso-8859-1"
X-Priority: 3
Organization: SORCUS Computer GmbH
Content-Transfer-Encoding: 7bit
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update:
I wrapped the calls to ioremap to align the requested address and range
to PAGE_SIZE. This helps. But when i do 'insmod' and 'rmmod' several
times i get severe Oops from kjournald.

Mit freundlichen Gruessen / Best regards
Dipl.-Phys. Christoph Baumann
---
SORCUS Computer GmbH
Im Breitspiel 11 c
D-69126 Heidelberg

Tel.: +49(0)6221/3206-0
Fax: +49(0)6221/3206-66
