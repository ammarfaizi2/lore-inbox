Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131186AbRBEL6c>; Mon, 5 Feb 2001 06:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131197AbRBEL6W>; Mon, 5 Feb 2001 06:58:22 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45074 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131186AbRBEL6H>; Mon, 5 Feb 2001 06:58:07 -0500
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Mon, 5 Feb 2001 11:58:05 +0000 (GMT)
Cc: ahzz@terrabox.com (Brian Wolfe), reiser@namesys.com (Hans Reiser),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        ionut@moisil.cs.columbia.edu (Ion Badulescu),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        kas@informatics.muni.cz (Jan Kasprzak)
In-Reply-To: <200102050408.f1548H243178@saturn.cs.uml.edu> from "Albert D. Cahalan" at Feb 04, 2001 11:08:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PkHY-0003BN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In an __init function, have some code that will trigger the bug.
> This can be used to disable Reiserfs if the compiler was bad.
> Then the admin gets a printk() and the Reiserfs mount fails.

Thats actually quite doable. I'll see about dropping the test into -ac that
way.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
