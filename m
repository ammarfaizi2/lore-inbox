Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286243AbRLTNQE>; Thu, 20 Dec 2001 08:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286237AbRLTNPz>; Thu, 20 Dec 2001 08:15:55 -0500
Received: from relay-2m.club-internet.fr ([195.36.216.171]:64460 "HELO
	relay-2m.club-internet.fr") by vger.kernel.org with SMTP
	id <S286242AbRLTNPk>; Thu, 20 Dec 2001 08:15:40 -0500
Message-ID: <3C21E47A.6060001@freesurf.fr>
Date: Thu, 20 Dec 2001 14:15:38 +0100
From: Kilobug <kilobug@freesurf.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011219
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: lkm <linux-kernel@vger.kernel.org>
Subject: init 0 freeze with kernel 2.5.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	On my Debian Sid system, when I type 'halt' or 'init 0' using kernel 
2.5.1, the systems blocks on "Init: sending KILL signal to all 
processes..." (console switching and magic sysrq still works). This 
doesn't happen with 2.4.* (2.4.15, 2.4.17-rc1, 2.4.17-rc2), and it 
didn't with 2.5.1-pre5.
	On all those kernels I've applied the preemptive patch and some patches 
from Netfiler's patch-o-matic. On 2.5.1 and 2.5.1-pre5, I've enabled 
devfs, not on 2.4.17-rc2.
	If you need additional infos, or if you additionals tests (like building 
the 2.5.1 without devfs or preempt) I can do it, but I go to holidays 
Saturday.

Thanx to you all !
-- 
** Gael Le Mignot "Kilobug", Ing3 EPITA - http://kilobug.free.fr **
Home Mail   : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

"Software is like sex it's better when it's free.", Linus Torvalds

