Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTJ1Mhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 07:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263955AbTJ1Mhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 07:37:36 -0500
Received: from enigma.barak.net.il ([212.150.48.99]:23747 "EHLO
	enigma.barak.net.il") by vger.kernel.org with ESMTP id S263945AbTJ1Mhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 07:37:35 -0500
From: "Amir Hermelin" <amir@montilio.com>
To: <linux-kernel@vger.kernel.org>
Subject: how do file-mapped (mmapped) pages become dirty?
Date: Tue, 28 Oct 2003 14:35:55 +0200
Organization: Montilio
Message-ID: <006901c39d50$0b1313d0$2501a8c0@CARTMAN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
When a process mmaps a file, how does the kernel know the memory has been
written to (and hence the page is dirty)? Is this done by setting the
protected flag, and when the memory is first written to it's set to dirty?
What function is responsible for this setting? And when will the page be
written back to disk (i.e. where's the flusher located)?

Thanks for any help,
Amir.


