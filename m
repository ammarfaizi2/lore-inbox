Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319015AbSHNJKa>; Wed, 14 Aug 2002 05:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319068AbSHNJKa>; Wed, 14 Aug 2002 05:10:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44719 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319015AbSHNJK3>;
	Wed, 14 Aug 2002 05:10:29 -0400
Date: Wed, 14 Aug 2002 02:00:15 -0700 (PDT)
Message-Id: <20020814.020015.83677829.davem@redhat.com>
To: ralf@linux-mips.org
Cc: imran.badr@cavium.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Cache coherency and snooping
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020814101654.B14197@linux-mips.org>
References: <20020814022958.B11645@linux-mips.org>
	<0aa401c2432e$04a95cc0$9e10a8c0@IMRANPC>
	<20020814101654.B14197@linux-mips.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ralf Baechle <ralf@linux-mips.org>
   Date: Wed, 14 Aug 2002 10:16:54 +0200
   
   If the latter was your intension then ioremap_nocache()
   will work as intended.

There are platforms btw where non-L2-cacheable access to RAM is
impossible.  It will hang the system in fact if one asked the cpu to
do it.
