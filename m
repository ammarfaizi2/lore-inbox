Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281168AbRKEOwp>; Mon, 5 Nov 2001 09:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281171AbRKEOwf>; Mon, 5 Nov 2001 09:52:35 -0500
Received: from ns.historage.com.tw ([203.66.155.1]:51695 "EHLO
	ns.falconstor.com.tw") by vger.kernel.org with ESMTP
	id <S281168AbRKEOw2>; Mon, 5 Nov 2001 09:52:28 -0500
Message-ID: <015701c16609$60f03ba0$9e041eac@Jim>
From: "Jim Liu" <jjliu@falconstor.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: unresolved symbol problem
Date: Mon, 5 Nov 2001 22:51:40 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, everyone,

I compile the module with kernel 2.4.9-6 and gcc-2.96-85, then insmod the
module with the same kernel. But I can't load this module. If I turn off
symbol versioning in the kernel config, I can load this module well. But I
hope to add the symbol version into the module. Could anyone give me some
hint?

Error message:
krudp.o: unresolved symbol exit_files_Rb860df9b
krudp.o: unresolved symbol skb_over_panic_Rf967a4cf
krudp.o: unresolved symbol add_wait_queue_R51e5fbbd
krudp.o: unresolved symbol exit_mm_R05afac94
krudp.o: unresolved symbol skb_free_datagram_R6bd0b0a5

Best Regards,
Jim (J. J. Liu)
Email: jjliu@falconstor.com.tw


