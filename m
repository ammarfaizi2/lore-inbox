Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269724AbSISBiQ>; Wed, 18 Sep 2002 21:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269725AbSISBiQ>; Wed, 18 Sep 2002 21:38:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62862 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269724AbSISBiQ>;
	Wed, 18 Sep 2002 21:38:16 -0400
Date: Wed, 18 Sep 2002 18:33:54 -0700 (PDT)
Message-Id: <20020918.183354.50766403.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: alexh@ihatent.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre7-ac2 compile and IrDA
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1032398756.24835.29.camel@irongate.swansea.linux.org.uk>
References: <3D891BD1.8F774946@digeo.com>
	<m3bs6uyerj.fsf_-_@lapper.ihatent.com>
	<1032398756.24835.29.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 19 Sep 2002 02:25:56 +0100

   On Thu, 2002-09-19 at 02:00, Alexander Hoogerhuis wrote:
   > irtty.c:761: `TIOCM_MODEM_BITS' undeclared (first use in this function)
   
   What architecture - its defined for x86 definitely

Really?  Maybe in the -ac tree, but not in what marcelo has.

? pwd
/home/davem/src/BK/marcelo-2.4/include/asm-i386
? egrep TIOCM_MODEM_BITS *.h
? cd ../../drivers/net/irda
? egrep TIOCM_MODEM_BITS *.c
irtty.c:        int arg = TIOCM_MODEM_BITS;
?
