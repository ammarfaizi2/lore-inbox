Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132860AbQLRBBU>; Sun, 17 Dec 2000 20:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132870AbQLRBBL>; Sun, 17 Dec 2000 20:01:11 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:4 "EHLO
	pobox.com") by vger.kernel.org with ESMTP id <S132860AbQLRBAx>;
	Sun, 17 Dec 2000 20:00:53 -0500
From: "Barry K. Nathan" <barryn@pobox.com>
Message-Id: <200012180030.QAA00753@pobox.com>
Subject: [BUG] 2.4.0test13-pre3 apm.o unresolved symbols
To: linux-kernel@vger.kernel.org
Date: Sun, 17 Dec 2000 16:30:46 -0800 (PST)
Reply-To: barryn@pobox.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try "modprobe apm" I get these errors:

/lib/modules/2.4.0-test13-pre3/kernel/arch/i386/kernel/apm.o: unresolved
symbol pm_send_all
/lib/modules/2.4.0-test13-pre3/kernel/arch/i386/kernel/apm.o: unresolved
symbol pm_active

This is my first time building APM as a module, so I don't know when the
error was first introduced...

-Barry K. Nathan <barryn@pobox.com>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
