Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbTAFEkm>; Sun, 5 Jan 2003 23:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbTAFEkm>; Sun, 5 Jan 2003 23:40:42 -0500
Received: from enchanter.real-time.com ([208.20.202.11]:55823 "EHLO
	enchanter.real-time.com") by vger.kernel.org with ESMTP
	id <S265982AbTAFEkl>; Sun, 5 Jan 2003 23:40:41 -0500
Date: Sun, 5 Jan 2003 22:49:14 -0600
From: Carl Wilhelm Soderstrom <chrome@real-time.com>
To: Dmitry Volkoff <vdb@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs corruption with 2.4.20 IDE+md+LVM
Message-ID: <20030105224909.C24674@real-time.com>
References: <20030106021412.GA3993@server1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030106021412.GA3993@server1>; from vdb@mail.ru on Mon, Jan 06, 2003 at 05:14:12AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 05:14:12AM +0300, Dmitry Volkoff wrote:
> > I observed filesystem corruption on my home workstation recently. I was
> > running kernel 2.4.20 (built myself with gcc 2.95.4), and ext3 with the
> > default journaling mode (ordered?).
> 
> Hello, 
> 
> Same problem here. I have software raid-1 on 2 IDE Seagate 80G, kernel 
> 2.4.20aa1 built with gcc-3.2, all filesystems are ext2, no LVM. 
> FS corruption after running Cerberus test for about 8 hours. 

glad to know I'm not the only one.

someone pointed out to me in a private e-mail, that the corruption may be
related to my VIA KT133 chipset. (they had a similar problem).

> > I will also point out that kernel 2.4.20-ac1 and 2.4.21-pre6 will not 
> > boot on my machine; they kernel panic when detecting my IDE devices. 
> 
> I can confirm. Kernel 2.4.21-pre2 does not boot from a RAID device 
> (/dev/md0). 

sorry about the thinko in my mail. I meant 2.4.21-pre1. Glad to know I'm not
crazy, but hopefully confirmation means it'll get fixed before 2.4.21-final.

<flamebait>
maybe I just missed the arguments since I wasn't reading LKML at the time;
but *why* is IDE being revamped in the middle of a "stable" kernel series?
however better it may be, I don't regard the existing situation as being bad
enough to justify the risk.
</flamebait>

Carl Soderstrom.
-- 
Systems Administrator
Real-Time Enterprises
www.real-time.com
