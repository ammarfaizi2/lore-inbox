Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130512AbQKQTVE>; Fri, 17 Nov 2000 14:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbQKQTUy>; Fri, 17 Nov 2000 14:20:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61292 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129270AbQKQTUn>; Fri, 17 Nov 2000 14:20:43 -0500
Subject: Re: ORACLE and 2.4-test10
To: jmerkey@timpanogas.org (Jeff V. Merkey)
Date: Fri, 17 Nov 2000 18:50:50 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dalecki@evision-ventures.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A15792F.D8891A69@timpanogas.org> from "Jeff V. Merkey" at Nov 17, 2000 11:30:07 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wqb5-00012V-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> performance, so we came up with something called direct FS, a separate
> File System interface just for Oracle.  The SOSD layer inside of Oracle

Yeah but you see thats ugly

> In NetWare, directFS was little more than a "raw" interface that
> bypassed the file cache.  It would be like having an API to a direct
> physical file system that never cached data in the buffer cache.  In

Its called O_DIRECT and kiovecs. Its already there. Much more generic than
an 'oraclefs'

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
