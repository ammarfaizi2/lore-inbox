Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131380AbQLPNSS>; Sat, 16 Dec 2000 08:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131823AbQLPNSJ>; Sat, 16 Dec 2000 08:18:09 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:53256 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S131380AbQLPNR4>;
	Sat, 16 Dec 2000 08:17:56 -0500
Date: Sat, 16 Dec 2000 14:47:16 +0200 (EET)
From: Jani Monoses <jani@virtualro.ic.ro>
To: viro@math.psu.edu
cc: linux-kernel@vger.kernel.org
Subject: mark_inode_dirty question
Message-ID: <Pine.LNX.4.10.10012161442080.10586-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

I see that
		( (inode->i_state & flags) != flags ) 

checked in __mark_inode_dirty as well as before it is called in
mark_inode_dirty and mark_inode_dirty_sync .Could the i_state be changed
during the call (on another CPU)?

Thanks 
Jani.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
