Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSEKMNz>; Sat, 11 May 2002 08:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316214AbSEKMNy>; Sat, 11 May 2002 08:13:54 -0400
Received: from ftp.nfas.org.sz ([196.28.7.66]:12673 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316213AbSEKMNx>; Sat, 11 May 2002 08:13:53 -0400
Date: Sat, 11 May 2002 13:51:33 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] opl3 OSS emulation compile fixes
In-Reply-To: <20020511061746.GA1845@wizard.com>
Message-ID: <Pine.LNX.4.44.0205111347320.29678-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002, A Guy Called Tyketto wrote:

>         No problem.. modprobe ran cleanly without any unresolved symbols. 
> however, with those programs needing OSS opl3 emulation (xmms, mpg123, 
> realplayer to name a few), this won't do much good less they forsake OSS 
> altogether. The 3 programs above (except xmms, which I believe works with 
> ALSA) depend on /dev/dsp existing for them to run. /dev/dsp gets created 
> (using DevFS here) when snd-pcm-oss.o is inserted at modprobe time. Hence, the 
> below:
> 
> root@bellicha:~# modprobe snd-fm801
> modprobe: Can't locate module snd-pcm-oss
> /lib/modules/2.5.15/kernel/sound/pci/snd-fm801.o: post-install snd-fm801 failed
> /lib/modules/2.5.15/kernel/sound/pci/snd-fm801.o: insmod snd-fm801 failed

But isn't that PCM OSS emulation? Did you compile with CONFIG_SND_PCM_OSS? 
>From what i see opl3_oss is WIP.

Forgive me if i'm missing something fundamental...

-- 
http://function.linuxpower.ca
		

