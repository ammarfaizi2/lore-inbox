Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129719AbRCGAtN>; Tue, 6 Mar 2001 19:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129709AbRCGAtD>; Tue, 6 Mar 2001 19:49:03 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:781 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129795AbRCGAso>; Tue, 6 Mar 2001 19:48:44 -0500
Subject: Re: Error compiling aic7xxx driver on 2.4.2-ac13
To: jamagallon@able.es (J . A . Magallon)
Date: Wed, 7 Mar 2001 00:51:29 +0000 (GMT)
Cc: kernel@theoesters.com (Phil Oester), linux-kernel@vger.kernel.org
In-Reply-To: <20010307010423.A1132@werewolf.able.es> from "J . A . Magallon" at Mar 07, 2001 01:04:23 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14aSAu-0001pw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which distro is yours ? In my Mandrake 8.0beta there is no /usr/include/db.
> Mdk offers the 3 db libs (db1, db2, db3), so I had to create a symlink
> /usr/include/db3 -> /usr/include/db.
> 
> Which is the standard path ? At least, Mdk and RH (Alan...) differ.

Im not too worried about this right now since as Al Viro pointed out the
libdb use is unneeded. 

The irony of all this was that the real concern Justin had and discussed with
people was about lex/bison/yacc being available, and the problem has been db
