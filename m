Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131179AbRACAtq>; Tue, 2 Jan 2001 19:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131609AbRACAtg>; Tue, 2 Jan 2001 19:49:36 -0500
Received: from 131-ZARA-X13.libre.retevision.es ([62.82.224.131]:55823 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S131179AbRACAtY>;
	Tue, 2 Jan 2001 19:49:24 -0500
Message-ID: <3A51DB11.350E663@zaralinux.com>
Date: Tue, 02 Jan 2001 14:43:45 +0100
From: Jorge Nerin <comandante@zaralinux.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease-diff i586)
X-Accept-Language: es-ES, es, en
MIME-Version: 1.0
To: Scott Conway <misassistant@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4 kernel halting...
In-Reply-To: <20010101180517.27929.qmail@web1103.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Conway wrote:
> 
> Hi, I'm having problems getting anything from
> 2.4.0-test12 onward to get past the IDE detectin phase
> of bootup, and not even 2.4.0-prerelease will work,
> either.  At the bottom of this is the output of dmesg,
> on my current kernel (2.4.0-test11), with the spot
> where test12+ freezes indicated.  btw...does anyone
> out there know how to capture output on a bad kernel;
> since the one I'm having trouble with never gets far
> enough for me to check for an oops with an externel
> program?  You can locate the point where I get the
> freeze by the whole line of '*' to show where it locks
> up.  Also, please forward any replies to my e-mail
> since I don't subscribe to linux-kernel due to
> excessive traffic on my end.  Thanks, and below is
> dmesg output...
> 
> ------------------------Cut
> Here-----------------------
> Linux version 2.4.0-test11-ac4 (root@ummagumma) (gcc
> version 2.95.3 19991030 (prerelease)) #1 Wed Dec 27
> 03:15:22 EST 2000

Try to compile with kgcc or egcs, gcc 2.95 is not a recommended
compiler, as it's know to miscompile somethings.

Search Makefile for HOSTCC and CC and chage it if needed.

-- 
Jorge Nerin
<comandante@zaralinux.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
