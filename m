Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261560AbREUOXl>; Mon, 21 May 2001 10:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbREUOXb>; Mon, 21 May 2001 10:23:31 -0400
Received: from kivc.vstu.vinnica.ua ([62.244.53.242]:4868 "EHLO
	kivc.vstu.vinnica.ua") by vger.kernel.org with ESMTP
	id <S261560AbREUOXQ>; Mon, 21 May 2001 10:23:16 -0400
Date: Mon, 21 May 2001 17:17:59 +0300
From: Bohdan Vlasyuk <bohdan@kivc.vstu.vinnica.ua>
To: linux-kernel@vger.kernel.org
Subject: Gdb reports about broken mmap()
Message-ID: <20010521171758.B9799@kivc.vstu.vinnica.ua>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !!

Well, don't warry about this issue any more :-). That's entirely
RedHat's mistake -- they didn't took a look at ./configure --help.
I've done ./configure --with-mmalloc and it does not complin amy more.
However, it still does not work :-))..

----------
17:16:02 ~/src/db # gdb -q dummy -m --batch
17:16:04 ~/src/db # gdb -q dummy
gdb-internal-error: objfiles.c (unlink_objfile): objfile already
unlinked
An internal GDB error was detected.  This may make make further
debugging unreliable.  Continue this debugging session? (y or n) n

Create a core file containing the current state of GDB? (y or n) n
----------

I guess now it's GNU's problems, not yours. Thanks.

-- 
WBR.
