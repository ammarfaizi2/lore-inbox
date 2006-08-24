Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWHXKIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWHXKIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWHXKIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:08:31 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:3771 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1751009AbWHXKIb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:08:31 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(203.129.230.146):SA:0(-102.5/1.7):. Processed in 1.546987 secs Process 21633)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Akinobu Mita" <mita@miraclelinux.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: RE: [RFC PATCH] prevent from killing OOM disabled task in do_page_fault()
Date: Thu, 24 Aug 2006 15:43:02 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMMENIDGAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20060823114019.GB7834@miraclelinux.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> The process protected from oom-killer may be killed when do_page_fault()
> runs out of memory. This patch skips those processes as well as init task.

Do we have any patch set to disable OOM all together for linux kernel
2.6.13?

Regards and anticipation,
Abu.


