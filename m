Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288338AbSAHVD4>; Tue, 8 Jan 2002 16:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288351AbSAHVDs>; Tue, 8 Jan 2002 16:03:48 -0500
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:36849 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S288338AbSAHVDg>; Tue, 8 Jan 2002 16:03:36 -0500
Date: Tue, 8 Jan 2002 22:02:29 +0100
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.2.20 vs 2.4.17 on 486 server
Message-ID: <20020108220229.A13462@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have simple 486 server with: 
- 2 ISA ethernet cards (eepro.o)
- ppp connection to Internet
I installed 2.4.17 (then 2.4.18-pre2) there, and discovered, that two connected
workstations has very bad Internet connection (for example it was impossible to
watch huge www pages or download pictures, edonkey/kza transfers were small).
So i tested:
- WWW speed on server -> OK (every page opens without problems) 
- scp transfer between server and workstations -> OK (more than 100KB/s)
There is squid installed on my server. But even if I used it on workstation -
WWW still works bad! Looks like something was really bad with MASQ. But
everything was OK on much faster (k6-2 500) system.

So I installed 2.2.20 - and all problems disappeared!

I am almost sure I compiled similiar stuff to every kernel, there was exactly
the same ipchains rules and route. How can I check what was bad with 2.4.x ? 

-- 
decopter - free SDL/OpenGL simulator under heavy development
download it from http://decopter.sourceforge.net
