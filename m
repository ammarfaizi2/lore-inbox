Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130210AbQKMXpT>; Mon, 13 Nov 2000 18:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130250AbQKMXpJ>; Mon, 13 Nov 2000 18:45:09 -0500
Received: from smtp2.Mountain.Net ([198.77.1.5]:38540 "EHLO
	nabiki.mountain.net") by vger.kernel.org with ESMTP
	id <S130210AbQKMXo6>; Mon, 13 Nov 2000 18:44:58 -0500
Message-ID: <3A1073B4.CDCA21DF@mountain.net>
Date: Mon, 13 Nov 2000 18:05:24 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Hard lockups solved
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My lockup problems started increasing in frequency, and it
became obvious that they were independent of the kernel I
booted. The shoe dropped, nic was failing. It's salvage now.

The bizarre shift errors on ftp are gone, so the data I sent
is irrelevant to the kernel.

The soft hangs I was getting were real, though perhaps
encouraged by nic failure. Your net/ipv4/tcp.c patch from
the NE2000 thread cured them even before I found the
hardware fault. Has that patch gone to the queue? I
recommend it.

Thanks,
Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
