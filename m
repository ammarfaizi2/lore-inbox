Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVAPPbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVAPPbM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 10:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVAPPbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 10:31:12 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:47378 "EHLO
	smtp-vbr13.xs4all.nl") by vger.kernel.org with ESMTP
	id S261253AbVAPPbJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 10:31:09 -0500
From: "Udo van den Heuvel" <udovdh@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Subject: VIA Rhine ethernet driver bug
Date: Sun, 16 Jan 2005 16:31:04 +0100
Message-ID: <000d01c4fbe0$64c1e010$450aa8c0@hierzo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On VIA-Rhine ethernet chips that give errors like:

Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x4 length 0 status 00000600!

(for all 16 entries)

Setting the mtu to a lower value than 1500 appears to help (tested at 500,
and 1000 is in progress).
Could this give a hint to the cause of the bug?


Kind regards,
Udo


