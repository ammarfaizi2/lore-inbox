Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130541AbQLZSzA>; Tue, 26 Dec 2000 13:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131649AbQLZSyv>; Tue, 26 Dec 2000 13:54:51 -0500
Received: from denise.shiny.it ([194.20.232.1]:58630 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S130541AbQLZSyg>;
	Tue, 26 Dec 2000 13:54:36 -0500
Message-ID: <3A4930FA.7C8E9F7C@denise.shiny.it>
Date: Tue, 26 Dec 2000 18:59:54 -0500
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.18 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linuxppc-dev@lists.linuxppc.org
Subject: USB related crashes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How to crash kernel 2.2.17-18:

Turn on the USB printer without paper and try
to print something. Wait for the "printer.c: usblp0:
out of paper" message and turn off the printer.
Ok, now "killall gs" will freeze the system.

(kernel 2.2.17-18, I did't try 2.4, GCC 2.95.3, PowerPC750)

Bye.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
