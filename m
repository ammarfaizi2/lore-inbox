Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSHJBOf>; Fri, 9 Aug 2002 21:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSHJBOf>; Fri, 9 Aug 2002 21:14:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20356 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316446AbSHJBOe>;
	Fri, 9 Aug 2002 21:14:34 -0400
Date: Fri, 09 Aug 2002 18:05:00 -0700 (PDT)
Message-Id: <20020809.180500.87139790.davem@redhat.com>
To: thunder@lightweight.ods.org
Cc: lkml@procter-collective.org.uk, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: Unix-domain sockets - abstract addresses
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208091632270.10270-100000@hawkeye.luckynet.adm>
References: <20020809145212.B1244@cad.citel.com>
	<Pine.LNX.4.44.0208091632270.10270-100000@hawkeye.luckynet.adm>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thunder from the hill <thunder@lightweight.ods.org>
   Date: Fri, 9 Aug 2002 16:33:18 -0600 (MDT)
   
   --- linus-2.5/net/unix/af_unix.c	Mon Aug  5 12:02:05 2002
   +++ thunder-2.5/net/unix/af_unix.c	Fri Aug  9 16:28:36 2002
   @@ -79,6 +79,8 @@
     *		  with BSD names.
     */
    
   +#undef unix	/* KBUILD_MODNAME */
   +

Explain to me what this giblet is for?
