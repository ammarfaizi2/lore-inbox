Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSHXFAW>; Sat, 24 Aug 2002 01:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSHXFAW>; Sat, 24 Aug 2002 01:00:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2721 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315279AbSHXFAW>;
	Sat, 24 Aug 2002 01:00:22 -0400
Date: Fri, 23 Aug 2002 21:49:13 -0700 (PDT)
Message-Id: <20020823.214913.90814419.davem@redhat.com>
To: zaitcev@redhat.com
Cc: geert@linux-m68k.org, linux-kernel@vger.kernel.org, jsimmons@infradead.org
Subject: Re: Little console problem in 2.5.30
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020824005756.A14783@devserv.devel.redhat.com>
References: <20020819023731.C316@devserv.devel.redhat.com>
	<Pine.GSO.4.21.0208191433430.23654-100000@vervain.sonytel.be>
	<20020824005756.A14783@devserv.devel.redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Sat, 24 Aug 2002 00:57:56 -0400

   > CONFIG_DUMMY_CONSOLE=n?
   
   This only works if CONFIG_FB is present

Not true, only video/Config.in has this (false) dependency.
If you say define_bool CONFIG_DUMMY_CONSOLE=y in Sparc configuration
then dummycon.o will be built by itself and it will work.
