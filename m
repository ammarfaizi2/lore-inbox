Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285677AbRLTAS6>; Wed, 19 Dec 2001 19:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285669AbRLTASj>; Wed, 19 Dec 2001 19:18:39 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:800 "EHLO
	tsmtp3.ldap.isp") by vger.kernel.org with ESMTP id <S285689AbRLTASe>;
	Wed, 19 Dec 2001 19:18:34 -0500
Date: Thu, 20 Dec 2001 01:20:46 +0100
From: Diego Calleja <grundig@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: green@namesys.com, reiserfs-list@namesys.com
Subject: Re: Reiserfs corruption on 2.4.17-rc1!
Message-ID: <20011220012046.A1866@diego>
In-Reply-To: <20011217025856.A1649@diego> <13425.1008580831@nova.botz.org> <20011218003359.A555@diego> <20011218125852.A1159@namesys.com> <20011218224848.C377@diego> <20011219095303.A11409@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20011219095303.A11409@namesys.com>; from green@namesys.com on Wed, Dec 19, 2001 at 07:53:03 +0100
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2001 07:53:03 Oleg Drokin wrote:
> Hello!
> 
> So why didn't you run reiserfsck --rebuild-tree then?
I've done it, under 2.4.17-rc2, It seems it's solved (although I can't know
what happened). reiserfsck -l -->

####### Pass 0 #######
"r5" got 142629 hits
####### Pass 1 #######
####### Pass 2 #######
####### Pass 3 #########
name "rpc" in directory 2 4160 points to nowhere 4160 68722 - removed
name "mtab" in directory 2 4160 points to nowhere 4160 68669 - removed
name "t1lib" in directory 2 4160 points to nowhere 4160 64508 - removed
name "hotplug" in directory 2 4160 points to nowhere 4160 63049 - removed
name "serial.conf" in directory 2 4160 points to nowhere 4160 68673 -
removed
name "sprucesig" in directory 2 4160 points to nowhere 4160 68377 - removed
dir 2 4160 has wrong sd_size 5792, has to be 5632
dir 1 2 has wrong sd_size 480, has to be 512
####### Pass 3a (lost+found pass) #########


Version 3.x.0K-pre13 (the last I found)
It seems all is working correctly). I'll try to reproduce the bug, althouh
I think it's no possible

Diego Calleja
> 
> Bye,
>     Oleg
> 


