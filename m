Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317154AbSEXPve>; Fri, 24 May 2002 11:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317157AbSEXPvd>; Fri, 24 May 2002 11:51:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41197 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317154AbSEXPv3>;
	Fri, 24 May 2002 11:51:29 -0400
Date: Fri, 24 May 2002 08:36:57 -0700 (PDT)
Message-Id: <20020524.083657.44280988.davem@redhat.com>
To: lochon@roulaise.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: hang. bug ? tcp.c recvmsg() 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CEE5E96.7EA1D748@roulaise.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Frederic Lochon (crazyfred)" <lochon@roulaise.net>
   Date: Fri, 24 May 2002 17:39:02 +0200
   
   I use:
   - Linux 2.4.17 SMP on Abit BP6 (dual celeron) with 384MB RAM
   - Usagi patch
   - preempt patch
   - lm-sensors patch
   - gcc version 2.95.3 20010315 (release)
   - binutils 2.11.2
   - glibc 2.2.4

Preempt + SMP == unreliable.  Try to reproduce with current
2.4.x and without the preempt patches.
