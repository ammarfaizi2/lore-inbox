Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUCQOzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 09:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUCQOzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 09:55:24 -0500
Received: from mail.siemenscom.com ([12.146.131.10]:25511 "EHLO
	mail.siemenscom.com") by vger.kernel.org with ESMTP id S261567AbUCQOzX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 09:55:23 -0500
Message-ID: <7A25937D23A1E64C8E93CB4A50509C2A0310F103@stca204a.bus.sc.rolm.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: linux-kernel@vger.kernel.org
Subject: 10MB buffer
Date: Wed, 17 Mar 2004 06:55:07 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running a SuSE 2.4.19 Kernel and have a requirement to allocate a 10MB
buffer (page aligned).

Is this possbile via alloc_bootmem_pages?

If so, how does my driver get access to this memory. I assume I have to
modify main.c to actually allocate the memory. My driver will get loaded
much later and this 10MB needs to be available all the time. Please CC me on
any responses.


Thanks in advance...

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com

