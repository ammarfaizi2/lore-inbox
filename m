Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135420AbRAGDry>; Sat, 6 Jan 2001 22:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135684AbRAGDro>; Sat, 6 Jan 2001 22:47:44 -0500
Received: from linuxjedi.org ([192.234.5.42]:58641 "EHLO linuxjedi.org")
	by vger.kernel.org with ESMTP id <S135420AbRAGDr2>;
	Sat, 6 Jan 2001 22:47:28 -0500
Message-ID: <3A57E6F6.EED83CD@roanoke.edu>
Date: Sat, 06 Jan 2001 22:48:06 -0500
From: "David L. Parsley" <parsley@roanoke.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cramfs & ramfs problems in 2.4.0 up to ac3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using root=/dev/ram0 and a cramfs initrd gives me 'wrong magic' when it
tries to boot.  Even more bizarre, if cramfs is compiled in the kernel
when I use a romfs root, it says 'wrong magic' then mounts the romfs but
can't find init.  If I take cramfs out of the kernel, the romfs mounts &
init runs fine.  I just saw this with ac3.

ramfs croaks with 'kernel BUG in filemap.c line 2559' anytime I make a
file in ac2 and ac3.  Works fine in 2.4.0 vanilla.  Should be quite
repeatable...

BTW, nice work on 2.4 everyone.

regards,
	David
--
David L. Parsley
Network Administrator
Roanoke College
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
