Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281150AbRKOWjk>; Thu, 15 Nov 2001 17:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281144AbRKOWja>; Thu, 15 Nov 2001 17:39:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33684 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281142AbRKOWjW>;
	Thu, 15 Nov 2001 17:39:22 -0500
Date: Thu, 15 Nov 2001 14:39:01 -0800 (PST)
Message-Id: <20011115.143901.121189547.davem@redhat.com>
To: groudier@free.fr
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small sym-2 fix
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011115203852.M2136-100000@gerard>
In-Reply-To: <20011115172204.B1589-100000@gerard>
	<20011115203852.M2136-100000@gerard>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=big5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id JAA11054

   From: Gérard Roudier <groudier@free.fr>
   Date: Thu, 15 Nov 2001 20:46:34 +0100 (CET)

   diff -u ../sym-2-orig/sym_glue.h ./sym_glue.h
   --- ../sym-2-orig/sym_glue.h	Thu Nov 15 22:53:34 2001
   +++ ./sym_glue.h	Thu Nov 15 23:18:58 2001
   @@ -77,7 +77,6 @@
    #include <linux/errno.h>
    #include <linux/pci.h>
    #include <linux/string.h>
   -#include <linux/malloc.h>
    #include <linux/mm.h>
    #include <linux/ioport.h>
    #include <linux/time.h>

Hmmm, why not add linux/slab.h?  It exists in every Linux kernel tree
your driver would ever be compiled under.
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
