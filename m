Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292398AbSBUOjA>; Thu, 21 Feb 2002 09:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292404AbSBUOiv>; Thu, 21 Feb 2002 09:38:51 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:1931 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S292398AbSBUOii>; Thu, 21 Feb 2002 09:38:38 -0500
Date: Thu, 21 Feb 2002 16:27:34 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christer Weinigel <wingel@acolyte.hack.org>, <wingel@nano-system.com>,
        <jgarzik@mandrakesoft.com>, <roy@karlsbakk.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <E16dtPo-0006vd-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0202211619320.11932-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Alan Cox wrote:

> Aside from the other comments Jeff made its got one bug that I only noticed
> because I fixed it in a pile of other stuff 8)
> open
> fork
> ioctl from two processes one per cpu at the same time

Thats a nice one =)

> NOWAYOUT support is missing - trivial to fix. Just remember to MOD_INC_USE..
> on the nowayout path

*Added to the TODO*

> Alan in pedantic mode

Thanks Alan and Jeff for the input, i'll cleanup this stuff. Out of 
interest, do we normally take in patches for specialised embedded boxes? I 
see the AMD Elan stuff got in but that only touched one area and was easy 
to integrate. I presume they'd get accepted if the code was broken up into 
seperate modules instead of being overly specialised. For example, the 
CRIS stuff in the Etrax tree (developer.axis.com).

Regards,
	Zwane Mwaikambo



