Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUG2CqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUG2CqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 22:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUG2CqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 22:46:19 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:639 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S263725AbUG2Cpp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 22:45:45 -0400
From: "Shawn Starr" <shawn.starr@rogers.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG][2.6.7+(or eariler)] Switching from LCD to external video w/ no external video connected causes deadlock
Date: Wed, 28 Jul 2004 22:45:58 -0400
Message-ID: <000201c47516$2dd74730$0200080a@panic>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed a few people with IBM Thinkpads running 2.6.7+ - different
models - have this problem. I don't know where in 2.6 this begin happening
though. 

When you use the function key and switch from LCD to External Video, the
system deadlocks. 
While ssh'd into the laptop the system has deadlocked once I switched video.
Unfortunately, I don't have a USB <-> Serial dongle handy yet ;-)

The Video card is a ATI Radeon 9600 64MB RAM, kernel has no framebuffer
support enabled.

Is this a known issue?

Thanks.

Shawn.

