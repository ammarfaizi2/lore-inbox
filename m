Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318019AbSGLWBd>; Fri, 12 Jul 2002 18:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318025AbSGLWBc>; Fri, 12 Jul 2002 18:01:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23980 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318019AbSGLWBa>;
	Fri, 12 Jul 2002 18:01:30 -0400
Date: Fri, 12 Jul 2002 14:55:24 -0700 (PDT)
Message-Id: <20020712.145524.91314408.davem@redhat.com>
To: thunder@ngforever.de
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org,
       ultralinux@vger.kernel.org
Subject: Re: L1_CACHE_SHIFT on sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0207121553230.3421-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0207121553230.3421-100000@hawkeye.luckynet.adm>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thunder from the hill <thunder@ngforever.de>
   Date: Fri, 12 Jul 2002 15:58:28 -0600 (MDT)

   What is the proper value for L1_CACHE_SHIFT on sparc64?
   The cache itself is two chunks of 16 bytes each, makes up 32 bytes. On 
   i386, L1_CACHE_BYTES == (1 << L1_CACHE_SHIFT), so if this applies here, 
   too, we have a L1_CACHE_SHIFT of... 5?

Right.  But who needs L1_CACHE_SHIFT?  Nothing generic should
reference it.  Did something get added to 2.5.x that needs it now?

I wouldn't have noticed yet as I've been away for nearly half a month
on vaction until a day or two ago.
