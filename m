Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311938AbSCXUoG>; Sun, 24 Mar 2002 15:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311937AbSCXUn4>; Sun, 24 Mar 2002 15:43:56 -0500
Received: from stingr.net ([212.193.33.37]:28086 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S311938AbSCXUnu>;
	Sun, 24 Mar 2002 15:43:50 -0500
Date: Sun, 24 Mar 2002 23:43:45 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
Message-ID: <20020324204345.GF3199@stingr.net>
Mail-Followup-To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
In-Reply-To: <3C9E1BD1.6040405@freenet.de> <E16pE0U-00073m-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Alan Cox:
> Thats up to the process. If a program doesn't handle malloc/mmap/etc
> failures then its junk anyway

The recent junk I fighting with to take full advantage of overcommit
accounting is squid.
Very popular junk. Maybe rsync uses same 'secret technique' to handle malloc
failures? :)))

Btw. Overcommit handling not very good yet.
Squid hits the limit, then bails out. Then shell script trying to start new
instance of squid (actually trying to sleep before restart), but gets 
'fork - cannot allocate memory'. seems that memory isn't dealloced 
from already exited process space :(

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
