Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLSAJs>; Mon, 18 Dec 2000 19:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLSAJi>; Mon, 18 Dec 2000 19:09:38 -0500
Received: from mail.valinux.com ([198.186.202.175]:6156 "EHLO mail.valinux.com")
	by vger.kernel.org with ESMTP id <S129391AbQLSAJ2>;
	Mon, 18 Dec 2000 19:09:28 -0500
Date: Mon, 18 Dec 2000 15:40:33 -0800
From: David Hinds <dhinds@valinux.com>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA modem (v.90 X2) not working with 2.4.0-test12 PCMCIA services
Message-ID: <20001218154033.C11728@valinux.com>
In-Reply-To: <007101c067cc$0500c620$0b31a3ce@g1e7m6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <007101c067cc$0500c620$0b31a3ce@g1e7m6>; from Miles Lane on Sat, Dec 16, 2000 at 05:52:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2000 at 05:52:30PM -0800, Miles Lane wrote:

> register_serial(): autoconfig failed
> serial_cs: register_serial() at 0x03e8, irq 3 failed.
> 
> "cardctl ident" shows:
> 
> Socket 1:
>     product info: "PCMCIA", "V.90 Communications Device ", "", ""
>     manfid: 0x018a, 0x0001

Have you tried, or could you try, using this card under a 2.2 kernel
for comparison?

Also, the first thing I'd try would be to exclude the irq 3, port
0x3e8-0x3ef resources in /etc/pcmcia/config.opts to verify that it is
not a resource conflict of some sort.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
