Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTIKObT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbTIKObS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:31:18 -0400
Received: from sphere.barak.net.il ([212.150.48.98]:6089 "EHLO
	sphere.barak.net.il") by vger.kernel.org with ESMTP id S261265AbTIKObP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:31:15 -0400
From: "Amir Hermelin" <amir@montilio.com>
To: <linux-kernel@vger.kernel.org>
Subject: page cache and buffer cache in 2.4.18 and up
Date: Thu, 11 Sep 2003 17:30:05 +0200
Organization: Montilio
Message-ID: <003301c37879$938fda00$0601a8c0@CARTMAN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Since the change in kernel 2.4, read and writes go both through the page and
buffer cache. Is the cached data held twice (i.e. uses twice the memory)? I
noticed that the struct page holds a pointer to a buffer-head list; does
that list contain actual data, or just pointers into the cached page data?

Thanks,
Amir.


