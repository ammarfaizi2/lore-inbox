Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129315AbRBMVTG>; Tue, 13 Feb 2001 16:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129793AbRBMVS5>; Tue, 13 Feb 2001 16:18:57 -0500
Received: from smtp8.xs4all.nl ([194.109.127.134]:31723 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129315AbRBMVSr>;
	Tue, 13 Feb 2001 16:18:47 -0500
From: thunder7@xs4all.nl
Date: Tue, 13 Feb 2001 22:17:59 +0100
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, keil@isdn4linux.de
Subject: Re: 2.2.19pre10 locks up hard on unloading the isdn module 'hisax.o' - 2.2.19pre11 does too!
Message-ID: <20010213221759.A718@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>SMP machine, 2x P3/700 on an Abit VP6.
>Never any trouble with the earlier 2.2.19pre's.
>
>a strace shows the hang to be in the delete_module("hisax") call.
>
>I'm having trouble with the sysrq-key, but I hope this is enough since
>there were some changes w.r.t. modules/locking etc. in pre10.
>
It's Linux, after all, so 2 minutes after creating this email
2.2.19pre11's announcement was here. I just tested it, and it has the
same problem.

from my config:

ISDN subsystem
#
CONFIG_ISDN=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_DRV_HISAX=m
CONFIG_HISAX_EURO=y
CONFIG_HISAX_W6692=y

Now, it's just one more crash and back to 2.2.19pre9 for me!

Good luck,
Jurriaan
-- 
When God is on the Bodhran
The atoms want to dance
	Oysterband - In your eyes
GNU/Linux 2.2.19pre11 SMP/ReiserFS 2x1402 bogomips load av: 0.05 0.34 0.20
