Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266448AbRGFL5b>; Fri, 6 Jul 2001 07:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266444AbRGFL5V>; Fri, 6 Jul 2001 07:57:21 -0400
Received: from [202.140.153.5] ([202.140.153.5]:54024 "EHLO
	techctd.techmas.hcltech.com") by vger.kernel.org with ESMTP
	id <S266438AbRGFL5H>; Fri, 6 Jul 2001 07:57:07 -0400
Message-ID: <3B45A7C1.7E684A7@techmas.hcltech.com>
Date: Fri, 06 Jul 2001 17:27:53 +0530
From: Vasu Varma P V <pvvvarma@techmas.hcltech.com>
Organization: HCL Technologies
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel Linux <linux-kernel@vger.kernel.org>
Subject: scheduling in kmalloc()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if we use any thing other than GFP_ATOMIC, does it result in scheduling
out the process if there is no memory available?
with GFP_KERNRL, I think we try freeing pages to service the current
request.
or is there any possibility of kmalloc() failing even with GFP_KERNEL?

thx,
Vasu.

