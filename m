Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316840AbSFBRVL>; Sun, 2 Jun 2002 13:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317212AbSFBRVK>; Sun, 2 Jun 2002 13:21:10 -0400
Received: from relay-1m.club-internet.fr ([194.158.104.40]:52208 "HELO
	relay-1m.club-internet.fr") by vger.kernel.org with SMTP
	id <S316840AbSFBRVJ>; Sun, 2 Jun 2002 13:21:09 -0400
Message-ID: <3CFA5411.3030600@freesurf.fr>
Date: Sun, 02 Jun 2002 19:21:21 +0200
From: Kilobug <kilobug@freesurf.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020601
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: lkm <linux-kernel@vger.kernel.org>
Subject: Very big shm area
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	I wanted to know if it is possible to have a very big system V shared 
memory segment (say about 1Gb) ?

	I've quickly looked into the source code of shm.c and shm.h in ipc/ and 
I've read the following:
/*
  * SHMMAX, SHMMNI and SHMALL are upper limits are defaults which can
  * be increased by sysctl
  */

But how far is it possible to increase them ? And which sysctl must be 
done ?

Thank you for answering,

-- 
** Gael Le Mignot "Kilobug", Ing3 EPITA - http://kilobug.free.fr **
Home Mail   : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

"Software is like sex it's better when it's free.", Linus Torvalds

