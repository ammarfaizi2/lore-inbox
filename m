Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWBVXSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWBVXSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWBVXSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:18:01 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24839 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030335AbWBVXSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:18:00 -0500
Date: Thu, 23 Feb 2006 00:17:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Enrico Weigelt <weigelt@metux.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Message-ID: <20060222231757.GJ4661@stusta.de>
References: <d9def9db0601072258v39ac4334kccc843838b436bba@mail.gmail.com> <E1EvUp6-0008Ni-00@calista.inka.de> <irf1s1hdoqbsf9cin627gh9tgrsb51htoe@4ax.com> <Pine.LNX.4.61.0601081303140.30148@yvahk01.tjqt.qr> <aap2s1diakl9dg7noa8a4p4kr688lhc1b5@4ax.com> <20060222192707.GB27398@nibiru.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222192707.GB27398@nibiru.local>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 08:27:07PM +0100, Enrico Weigelt wrote:
> 
> BTW: I had a similar problem after switching from 2.6.8.1 
> to 2.6.15 ... the whole machine (athlon-xp) behaves extremly
> slow and not even playing mp3 worked without hangs. 
> 
> So I switched back to old 2.6.8.1 for now ...

A better solution would be if it could be determined what your problem 
is.

Could you try 2.6.16-rc4?

If the problem is still present, please open a bug report at the kernel 
Bugzilla [1] with an explanation of your problem, your .config with 
2.6.16-rc4 and the output of "dmesg -s 1000000" in both 2.6.8.1 and 
2.6.16-rc4.

We should fix regressions like yours, but this requires bug reports 
notifying us about problems.

> cu

TIA
Adrian

[1] http://bugzilla.kernel.org/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

