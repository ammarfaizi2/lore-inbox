Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTEFDYB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbTEFDYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 23:24:01 -0400
Received: from exchsrv1.cs.washington.edu ([128.95.3.128]:29562 "EHLO
	exchsrv1.cseresearch.cs.washington.edu") by vger.kernel.org with ESMTP
	id S262321AbTEFDYA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:24:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Buggy drivers/modules needed
Date: Mon, 5 May 2003 20:36:32 -0700
Message-ID: <2B0E86920B2B9C43A043DA80E447FCBC7BB895@exchsrv1.cseresearch.cs.washington.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Buggy drivers/modules needed
Thread-Index: AcMTgNBFXehet51CRX6unsOPURc3xw==
From: "Michael Swift" <mikesw@cs.washington.edu>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a Linux patch to prevent buggy modules/drivers from causing the kernel to crash. Instead, the kernel detects a crash in the driver, and transparently restarts the module. Currently this patch supports network interface card drivers, sound drivers, and file systems.

I've tested the patch by generating artifical bugs in drivers, but I want to see how well it works on real bugs.

What I would like is either:

a) sound card, network interface, or file system code with bugs that cause an oops. In particular, a pointer to what piece of code causes the oops would be helpful.

b) fragments of code from any kernel module that has caused an oops. I can splice this code into existing modules to see if it can be successfully isolated.

Thanks in advance

- Mike Swift
