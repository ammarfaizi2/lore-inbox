Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbVHIJlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVHIJlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVHIJlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:41:03 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:59578 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S932489AbVHIJlB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:41:01 -0400
Message-ID: <1123580455.42f87a2752768@imp4-q.free.fr>
Date: Tue, 09 Aug 2005 11:40:55 +0200
From: jfontain@free.fr
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc6: 3c574 fails: interrupt(s) dropped: solved
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 195.101.92.253
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC me as I am not subscribed)

Just wanted to thank you for solving the above problem, where a 3com pcmcia card
failed on an older laptop.
I saw in the 2.6.13-rc6 log that some work on yenta and PCI had been done. So I
tried kernel 2.6.12-1.1456_FC5 from the Fedora development repository, and I got
it to work but only with the irqpoll option (details including dmesg output at
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=163952).

Excellent work!


Jean-Luc


