Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265311AbRFVC0X>; Thu, 21 Jun 2001 22:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265310AbRFVC0O>; Thu, 21 Jun 2001 22:26:14 -0400
Received: from femail3.sdc1.sfba.home.com ([24.0.95.83]:32398 "EHLO
	femail3.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S265311AbRFVC0G>; Thu, 21 Jun 2001 22:26:06 -0400
Date: Thu, 21 Jun 2001 22:25:57 -0400
From: Tom Vier <tmv5@home.com>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac17
Message-ID: <20010621222557.A553@zero>
In-Reply-To: <20010621173855.A6444@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010621173855.A6444@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Thu, Jun 21, 2001 at 05:38:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i having some strange vm behavour with -ac17 that didn't happen with -ac14
(i haven't tried 15 or 16). it starts swapping even when i have hundreds of
megs of free ram. another strange thing is that the first time i tried to
boot ac17, it machine checked in the palcode. i hit reset and it booted
correctly.

vmstat:
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0   2864 408488   2488  67080   0   0   216    28 1052   470  83   4  13

buffermem:
2	10	60

freepages:
255	510	765

pagecache:
2	15	75

pagetable_cache:
25	50

also, overcommit_memory is 1

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
