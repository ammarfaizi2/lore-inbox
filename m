Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbTATTiN>; Mon, 20 Jan 2003 14:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbTATTiN>; Mon, 20 Jan 2003 14:38:13 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3076 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266777AbTATTiL>;
	Mon, 20 Jan 2003 14:38:11 -0500
Date: Sun, 19 Jan 2003 19:28:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Wolfgang Fritz <wolfgang.fritz@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsuspend: possible with VIA Eden processor? Or alternatives?
Message-ID: <20030119182831.GA16599@elf.ucw.cz>
References: <b0c20t$rt$1@fritz38552.news.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c20t$rt$1@fritz38552.news.dfncis.de>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> the swsuspend mini howto says that a processor with pse/pse36 feature is 
> required for swsupend in 2.4.
> 
> The VIA Eden processor on my EPIA ME6000 board gives:
> 
> vdr:~ # cat /proc/cpuinfo
> processor       : 0
> vendor_id       : CentaurHauls
> cpu family      : 6
> model           : 7
> model name      : VIA Samuel 2
> stepping        : 3
> cpu MHz         : 599.731
> cache size      : 64 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu de tsc msr cx8 mtrr pge mmx 3dnow
> bogomips        : 1196.03
> 
> So I am obviously out of luck with 2.4 kernels, but what about 2.5 (the 
> mini-howto is silent here)?

Same there. With some hacking, it may be possile to fix it.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
