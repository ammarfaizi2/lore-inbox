Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWHVXtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWHVXtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 19:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWHVXtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 19:49:33 -0400
Received: from s8.lansco.de ([85.10.209.66]:32814 "EHLO s8.lansco.de")
	by vger.kernel.org with ESMTP id S932278AbWHVXtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 19:49:33 -0400
From: "Bjo Breiskoll" <bjo@nefkom.net>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Relay Subsystem the 2nd.
Date: Wed, 23 Aug 2006 01:49:29 +0200
Message-ID: <002d01c6c645$9be1afe0$03b2a8c0@bjoserver>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AcbGRVJZtpOCoW0STnuwhIUhbKf8zQ==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
back to my question last week. I would like to implement a new kernel-modul
with the ability to write data from kernelspace to userspace via the new
relay subsystem. The less info from block/blktrace.c is insufficient
unfortunately. The userspace-program should be able to "listen" to the
kernel-modul if there is new data written. My first Implementation with data
exchange over copy_to_user() and a char-device is insufficient. So i need an
hint for something like blocked-IO for relay-files. Is this possible with
the new relay-subsystem?
 
Thanx in advance
BJO

