Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263011AbRFJWfe>; Sun, 10 Jun 2001 18:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263060AbRFJWfY>; Sun, 10 Jun 2001 18:35:24 -0400
Received: from grobbebol.xs4all.nl ([194.109.248.218]:60968 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263011AbRFJWfH>; Sun, 10 Jun 2001 18:35:07 -0400
Date: Sun, 10 Jun 2001 22:34:28 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: process table fills with DN state when nfs connection is lost
Message-ID: <20010610223428.A27096@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-OS: Linux grobbebol 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi *

I have a network with a different linux system hat exports a few dirs to
this system.

what happens is this : the other system reboots into windows o the nfs
connection gets lost. however, what happens is that now the process
table starts to fill with cron initiated mrtg calls and all get the DN
state in ps aux.

now, the load goes up and when I came home it was at 144 already. I
stopped cron, unable to kill off the mrtg calls. I then re-established
the nfs connection by rebooting the windows back to linux; I then could
umount the nfs shares and guess what happened -- all DN processes went
ayway and the system load back to normal.

it seems that some things block in the kernel when the nfs stuff is
failed. is this right ? is my setup incorrect or what ?

Roeland

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
