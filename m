Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318473AbSIBUu6>; Mon, 2 Sep 2002 16:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318487AbSIBUu6>; Mon, 2 Sep 2002 16:50:58 -0400
Received: from node-c-067b.a2000.nl ([62.194.6.123]:35946 "HELO
	pipc.pipsels.pip") by vger.kernel.org with SMTP id <S318473AbSIBUu5>;
	Mon, 2 Sep 2002 16:50:57 -0400
Date: Mon, 2 Sep 2002 22:55:21 +0200
From: Remco Post <r.post@sara.nl>
To: "Tom Rini" <trini@kernel.crashing.org>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] reiserfs patch, was  Re: Linux v2.5.33, compile error on powermac
Message-Id: <20020902225521.495bff19.r.post@sara.nl>
In-Reply-To: <20020902193841.GG761@opus.bloom.county>
References: <Pine.LNX.4.33.0208311514430.6221-100000@penguin.transmeta.com>
	<B0754740-BE6F-11D6-9030-000393911DE2@sara.nl>
	<20020902193841.GG761@opus.bloom.county>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2002 12:38:41 -0700
"Tom Rini" <trini@kernel.crashing.org> wrote:

> fs/reiserfs/resize.c needs to include <linux/mm.h>, iirc.  Make a patch
> and send it to the trivial patch monkey and/or Linus.
> 

So very true, here it is...


*** linux-2.5.33/fs/reiserfs/resize.c.org	Mon Sep  2 22:48:25 2002
--- linux-2.5.33/fs/reiserfs/resize.c	Mon Sep  2 22:27:59 2002
***************
*** 9,14 ****
--- 9,15 ----
   */
  
  #include <linux/kernel.h>
+ #include <linux/mm.h>
  #include <linux/vmalloc.h>
  #include <linux/string.h>
  #include <linux/errno.h>
