Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTKXEuD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 23:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbTKXEuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 23:50:03 -0500
Received: from bay10-dav61.bay10.hotmail.com ([64.4.37.235]:54032 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263598AbTKXEuB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 23:50:01 -0500
X-Originating-IP: [24.101.31.88]
X-Originating-Email: [penguin2047@hotmail.com]
From: "John Smith" <penguin2047@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: PTE --> 2 values??
Date: Sun, 23 Nov 2003 23:50:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <BAY10-DAV61cvpzTHkz0000160a@hotmail.com>
X-OriginalArrivalTime: 24 Nov 2003 04:50:00.0265 (UTC) FILETIME=[6A9D3B90:01C3B246]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw that Linux is using a 3 level page tables, pgd, pmd and pte. The value
in the pte can refer to an actual page in memory OR an address on the swap
device. How does the kernel distinguish the two values such that if the
value is refering to an swap device address, it will not lookup the address
in memory ??


John.
