Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287612AbSAIPbg>; Wed, 9 Jan 2002 10:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287615AbSAIPb0>; Wed, 9 Jan 2002 10:31:26 -0500
Received: from stratus.swi.com.br ([200.203.204.140]:36310 "EHLO
	stratus.swi.com.br") by vger.kernel.org with ESMTP
	id <S287612AbSAIPbV>; Wed, 9 Jan 2002 10:31:21 -0500
Posted-Date: Wed, 9 Jan 2002 13:31:08 -0200
X-Local-Destination: linux-kernel@vger.kernel.org
X-Local-Origin: aris@cathedrallabs.org
X-Gateway: Speedway Internet Service http://www.swi.com.br
Date: Wed, 9 Jan 2002 13:27:52 -0200
To: Jacek Pop?awski <jpopl@interia.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new eepro driver seems broken
Message-ID: <20020109152752.GG1954@cathedrallabs.org>
In-Reply-To: <20020109125532.A1118@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020109125532.A1118@localhost.localdomain>
From: aris <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I assume there is the same version of eepro driver in 2.2.21-pre2 and 2.4.17.
> 
> Version included in kernel 2.2.20 is broken, becouse sometime ethernet card
> "dies" - I can't ping it from outside. However, when eepro card is in server,
> and I ping workstation from there - card works again. So my current solution is
> script which pings everything in localnet all the time.
yes, it's broken

> But new version works much worse for me. In 2.2.21-pre2 and 2.4.17 card never
> dies - it always work, but there are many problems with connections. I thought
> it's problem with MASQ, but it behaves exactly the same on 2.2 and 2.4. When I
> send single file by scp - I have transfer bigger than 100KB/s. But when I watch
> WWW or use p2p - transfer is very small or stops.
the 0.13 version had this mention: become stable. performance is scheduled
for next versions. you may try eepro.c from 2.2.13 kernel but as i could see
it's less stable than 0.13 version.

> Driver from 2.2.20 works bad, newer driver works bad, too, but in another way.
> Where can I find older releases of eepro driver? How can I contact author
> (email from eepro.c doesn't work) ? Is anyone still using EtherExpress ISA 10 ? 
i think there's nobody else working on this driver right now. you may send
questions to lkml with a copy to me.

-- 
aris
