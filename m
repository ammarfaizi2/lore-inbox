Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285618AbSAPR6q>; Wed, 16 Jan 2002 12:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285498AbSAPR6e>; Wed, 16 Jan 2002 12:58:34 -0500
Received: from s1.relay.oleane.net ([195.25.12.48]:25263 "HELO
	s1.relay.oleane.net") by vger.kernel.org with SMTP
	id <S284902AbSAPR4s>; Wed, 16 Jan 2002 12:56:48 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linux-kernel@vger.kernel.org>, Thomas Capricelli <tcaprice@logatique.fr>
Subject: Re: Automatic reboot on PPC (was: Re: Two issues with 2.4.18pre3 on
 PPC)
Date: Wed, 16 Jan 2002 18:55:24 +0100
Message-Id: <20020116175525.31579@smtp.adsl.oleane.com>
In-Reply-To: <20020116165420.9814923CBB@persephone.dmz.logatique.fr>
In-Reply-To: <20020116165420.9814923CBB@persephone.dmz.logatique.fr>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>	btw, i've heard there was a trick to enable automatic reboot of apple 
>powermac after a power failure (broken link on www.penguinppc.org, I've even 
>asked webmasters whithout having any response)
>
>	My main server/gateway/firewall _is_ a PPC running linux, and I would damn 
>like to know this trick !
>
>thanx for any pointer/answer/whatever..

The actual command to send to /dev/adb is different depending if
your machine has the Cuda or the PMU chip for controlling power.

Also, it sorta have to be reset in the kernel when doing a normal
shutdown or your machine will always come back up ;) So we need
some kind of userland script putting it back ON and the kernel
putting it back off.

I'll go dig around to find the exact commands, but you could well
post a message to the linuxppc-dev and get a reply before I find
that out ;)

Ben.


