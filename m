Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQKQJYM>; Fri, 17 Nov 2000 04:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129510AbQKQJYC>; Fri, 17 Nov 2000 04:24:02 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:17418 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S129325AbQKQJX6>;
	Fri, 17 Nov 2000 04:23:58 -0500
Date: Fri, 17 Nov 2000 10:53:52 +0200 (EET)
From: <jani@virtualro.ic.ro>
To: linux-kernel@vger.kernel.org
Subject: newbie Q:unnecessarily included header files ?
Message-ID: <Pine.LNX.4.10.10011171043000.3520-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	if drivers in the tree still compile (and work) after 	removing
some #include -s does it mean that they don't need them at all?
	May they fail to compile on other arch -s ?

     For instance vgacon.c  includes among others fs.h which it seems
never to use.I could send a patch for it.
	
Are these frequent in the tree?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
