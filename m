Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTE2U7c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTE2U7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:59:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60840 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262861AbTE2U55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:57:57 -0400
Date: Thu, 29 May 2003 14:09:26 -0700 (PDT)
Message-Id: <20030529.140926.112618236.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: mika.penttila@kolumbus.fi, rmk@arm.linux.org.uk, akpm@digeo.com,
       hugh@veritas.com, LW@karo-electronics.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0305291738000.5042-100000@serv>
References: <Pine.LNX.4.44.0305290151470.5042-100000@serv>
	<20030528.183700.104033543.davem@redhat.com>
	<Pine.LNX.4.44.0305291738000.5042-100000@serv>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Thu, 29 May 2003 19:49:15 +0200 (CEST)

   cachetlb.txt also says "_OR_ the kernel is about to read from a page cache 
   page..." and it's used like this in mm/filemap.c.

That's correct.

   I think it would be better to move this into a separate function,

How about just a flag, saying which event is occuring/about-to-occur?
   
Franks a lot,
David S. Miller
davem@redhat.com
