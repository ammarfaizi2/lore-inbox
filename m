Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262663AbSJLBlQ>; Fri, 11 Oct 2002 21:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSJLBlQ>; Fri, 11 Oct 2002 21:41:16 -0400
Received: from dp.samba.org ([66.70.73.150]:448 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262663AbSJLBlP>;
	Fri, 11 Oct 2002 21:41:15 -0400
Date: Sat, 12 Oct 2002 11:43:32 +1000
From: Anton Blanchard <anton@samba.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: James Simmons <jsimmons@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [BK PATCH] console changes 1
Message-ID: <20021012014332.GA7050@krispykreme>
References: <Pine.LNX.4.33.0210111009170.4030-100000@maxwell.earthlink.net> <1749543871.1034360975@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1749543871.1034360975@[10.10.2.3]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Are you going to have early console support (ie printk from before
> what is now console_init) done before the freeze, or should I just 
> submit our version?

On ppc64 Im currently setting a console up very early in arch init code
and using the CONFIG_EARLY_PRINTK hook to disable it at console_init
time. Works OK for me, do you guys need something on top of that?

Anton
