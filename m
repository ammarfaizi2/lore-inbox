Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTE0ME6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTE0ME6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:04:58 -0400
Received: from tomts24-srv.bellnexxia.net ([209.226.175.187]:3522 "EHLO
	tomts24-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263309AbTE0ME5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:04:57 -0400
Date: Tue, 27 May 2003 08:16:41 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: "riscom.o" build error under 2.5.70
Message-ID: <Pine.LNX.4.44.0305270757500.20368-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  the final output from a "make allyesconfig" of 2.5.70 on RH 9 (seems 
like the riscom code has been a problem for a while, no?):


... snip ...

  CC      drivers/char/riscom8.o
In file included from drivers/char/riscom8.c:51:
drivers/char/riscom8.h:88: field `tqueue' has incomplete type
drivers/char/riscom8.h:89: field `tqueue_hangup' has incomplete type
drivers/char/riscom8.c:84: warning: type defaults to `int' in declaration of `DECLARE_TASK_QUEUE'
drivers/char/riscom8.c:84: warning: parameter names (without types) in function declaration
drivers/char/riscom8.c:142: confused by earlier errors, bailing out
make[2]: *** [drivers/char/riscom8.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2



rday

