Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273938AbRIXPfq>; Mon, 24 Sep 2001 11:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273952AbRIXPfg>; Mon, 24 Sep 2001 11:35:36 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:8788 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S273938AbRIXPf2> convert rfc822-to-8bit; Mon, 24 Sep 2001 11:35:28 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: __alloc_pages: 0-order allocation failed
Date: Mon, 24 Sep 2001 17:33:58 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0109240933390.1593-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0109240933390.1593-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E15lXlS-0004WS-00@mrvdom01.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For the people having the allocation failure problems, please try the
> following patch.

I tried it. No success.
dmesg: after the "bad" program I wrote some mail ago.

__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0123cc1
VM: killing process a.out

I forgot to mention:

c0123c60 t page_cache_read
c0123d10 t read_cluster_nonblocking

If you need  a backtrace, we should insert a panic into the code to get a 
full back trace for the debugging.

greetings

Christian Bornträger
