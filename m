Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275077AbTHGFtx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 01:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275091AbTHGFtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 01:49:53 -0400
Received: from core.kaist.ac.kr ([143.248.147.118]:25793 "EHLO
	core.kaist.ac.kr") by vger.kernel.org with ESMTP id S275077AbTHGFtw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 01:49:52 -0400
Message-ID: <005a01c35ca7$210f71e0$a5a5f88f@core8fyzomwjks>
From: "Cho, joon-woo" <jwc@core.kaist.ac.kr>
To: <linux-kernel@vger.kernel.org>
Subject: [Q] How can I transfer data from hard disk to PCI device's memory
Date: Thu, 7 Aug 2003 14:45:37 +0900
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I want to transfer data 'directly' from hard disk to some PCI device which
has memory

with the helpf of kernel(file system, device driver).

In above sentence 'directly' means that data does not go through main memory
of host.


So I am analyzing kernel code, but I am so confused because of memory system

complexity (page, buffer, ... ).

I find buffer head structure(struct buffer_head) has b_data pointer
variable.

I think kernel transfer data from HDD to this pointer variable.

Can I map this pointer variable(b_data) to PCI device's memory?


I am very confused because this part is highly related with complex memory
system

(page & buffer).

Please give me some hint. Thanks.


