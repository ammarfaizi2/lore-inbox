Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311236AbSCLPa2>; Tue, 12 Mar 2002 10:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310182AbSCLPaT>; Tue, 12 Mar 2002 10:30:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:43979 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311236AbSCLPaF>;
	Tue, 12 Mar 2002 10:30:05 -0500
Date: Tue, 12 Mar 2002 07:25:31 -0800 (PST)
Message-Id: <20020312.072531.109169457.davem@redhat.com>
To: ak@muc.de
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: __get_user usage in mm/slab.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020312162316.A3505@averell>
In-Reply-To: <Pine.LNX.4.21.0203121237070.19747-100000@serv>
	<20020312162316.A3505@averell>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@muc.de>
   Date: Tue, 12 Mar 2002 16:23:16 +0100

   I guess set_fs(KERNEL_DS); __*_user() will not catch exceptions on m68k
   currently, right? 

I, for one, think it should.
