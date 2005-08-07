Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752431AbVHGRXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbVHGRXg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 13:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbVHGRXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 13:23:36 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16901 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752430AbVHGRXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 13:23:35 -0400
Date: Sun, 7 Aug 2005 19:23:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Espen =?iso-8859-1?Q?Fjellv=E6r?= Olsen <espenfjo@gmail.com>
Cc: linux <linux-kernel@vger.kernel.org>, netfilter-devel@lists.netfilter.org,
       netdev@vger.kernel.org, discuss@x86-64.org
Subject: Re: 2.6.13-rc4-mm1: iptables DROP crashes the computer
Message-ID: <20050807172333.GF3513@stusta.de>
References: <7aaed091050807100843454603@mail.gmail.com> <7aaed09105080710121bba1b5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7aaed09105080710121bba1b5b@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2005 at 07:12:00PM +0200, Espen Fjellvær Olsen wrote:

> After execing "iptables -A INPUT -j DROP" my computer crashes hard. It
> dosent hang immediately, but after a couple of seconds.
> The machine is an amd64, running a clean x86_64 environment.
> uname -a: Linux gentoo 2.6.13-rc4-mm1 #1 PREEMPT Thu Aug 4 01:01:44
> CEST 2005 x86_64 AMD Athlon(tm) 64 Processor 3400+ AuthenticAMD
>...

Is this reproducible or did it happen only once?

Are there any messages that might give a hint where to search for the 
problem?

You are reporting this against 2.6.13-rc4-mm1, but are attaching a 
.config of 2.6.13-rc5-mm1. Which kernels are affected, and which are 
not?

Does it still happen if you compile your kernel with preemption 
disabled?

Please send the output of ./scripts/ver_linux .

> Mvh / Best regards
> Espen Fjellvær Olsen

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

