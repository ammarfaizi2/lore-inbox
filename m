Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130696AbQKQJxz>; Fri, 17 Nov 2000 04:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131485AbQKQJxp>; Fri, 17 Nov 2000 04:53:45 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:61314 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S130696AbQKQJxj>;
	Fri, 17 Nov 2000 04:53:39 -0500
Message-ID: <20001117172336.B27444@saw.sw.com.sg>
Date: Fri, 17 Nov 2000 17:23:36 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@redhat.com>
Subject: eepro100 driver update for 2.4
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've updated eepro100 driver for 2.4 kernel branch.
So far, the most annoying initialization problem (expressing itself in "card
reports no resources" messages) hasn't been fixed.

The driver is available at
ftp://ftp.sw.com.sg/pub/Linux/people/saw/kernel/v2.4/eepro100.c

The main changes are:
 - fixes for 64-bit architectures (rx_copybreak, additional cpu_to_le32,
   PCI_DMA_BIDIRECTIONAL for RX descriptions)
 - a couple of timing fixes
 - a lot of code cleanup, minor fixes.
See ftp://ftp.sw.com.sg/pub/Linux/people/saw/kernel/v2.4/eepro100.changelog
for a detailed log.

Best regards
		Andrey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
