Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbTE0MTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTE0MTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:19:39 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:44479 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263328AbTE0MTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:19:35 -0400
Date: Tue, 27 May 2003 08:31:22 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.70, "specialix.o" build error
Message-ID: <Pine.LNX.4.44.0305270827530.32586-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  once again, based on "make allyesconfig":

  CC      drivers/char/specialix.o
In file included from drivers/char/specialix.c:130:
drivers/char/specialix_io8.h:127: field `tqueue' has incomplete type
drivers/char/specialix_io8.h:128: field `tqueue_hangup' has incomplete type
drivers/char/specialix.c:174: warning: type defaults to `int' in declaration of `DECLARE_TASK_QUEUE'
drivers/char/specialix.c:174: warning: parameter names (without types) in function declaration
drivers/char/specialix.c:174: warning: data definition has no type or storage class
drivers/char/specialix.c:221: confused by earlier errors, bailing out
make[2]: *** [drivers/char/specialix.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2




rday

