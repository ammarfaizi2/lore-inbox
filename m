Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286238AbSAIL44>; Wed, 9 Jan 2002 06:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285828AbSAIL4q>; Wed, 9 Jan 2002 06:56:46 -0500
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:33664 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S285134AbSAIL4l>; Wed, 9 Jan 2002 06:56:41 -0500
Date: Wed, 9 Jan 2002 12:55:32 +0100
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: new eepro driver seems broken 
Message-ID: <20020109125532.A1118@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I assume there is the same version of eepro driver in 2.2.21-pre2 and 2.4.17.

Version included in kernel 2.2.20 is broken, becouse sometime ethernet card
"dies" - I can't ping it from outside. However, when eepro card is in server,
and I ping workstation from there - card works again. So my current solution is
script which pings everything in localnet all the time.

But new version works much worse for me. In 2.2.21-pre2 and 2.4.17 card never
dies - it always work, but there are many problems with connections. I thought
it's problem with MASQ, but it behaves exactly the same on 2.2 and 2.4. When I
send single file by scp - I have transfer bigger than 100KB/s. But when I watch
WWW or use p2p - transfer is very small or stops.

Driver from 2.2.20 works bad, newer driver works bad, too, but in another way.
Where can I find older releases of eepro driver? How can I contact author
(email from eepro.c doesn't work) ? Is anyone still using EtherExpress ISA 10 ? 

-- 
decopter - free SDL/OpenGL simulator under heavy development
download it from http://decopter.sourceforge.net
