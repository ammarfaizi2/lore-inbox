Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbULOEuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbULOEuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 23:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbULOEuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 23:50:16 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:54025 "EHLO
	smtp-vbr13.xs4all.nl") by vger.kernel.org with ESMTP
	id S261875AbULOEuG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 23:50:06 -0500
From: "Udo van den Heuvel" <udovdh@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc3-mm1 on a EPIA CL-6000 gives weird eth1 messages
Date: Wed, 15 Dec 2004 05:50:02 +0100
Message-ID: <000c01c4e261$89bff3e0$450aa8c0@hierzo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: High
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.10-rc3-mm1 on a EPIA CL-6000 gives weird eth1 messages:

Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x2 length 0 status 00000600!
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame c74dd020 vs
c74dd020.
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x3 length 0 status 00000400!
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame c74dd030 vs
c74dd030.
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x4 length 0 status 00000400!
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame c74dd040 vs
c74dd040.
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x5 length 0 status 00000400!
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame c74dd050 vs
c74dd050.
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x6 length 0 status 00000400!
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame c74dd060 vs
c74dd060.
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x7 length 7840 status 1ea08d10!
Dec 14 17:32:30 epia kernel: eth1: Oversized Ethernet frame c74dd070 vs
c74dd070.

I googled a bit and this is said to be a bug?

Kind regards,
Udo


