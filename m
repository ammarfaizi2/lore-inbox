Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbTCHBOp>; Fri, 7 Mar 2003 20:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261612AbTCHBOp>; Fri, 7 Mar 2003 20:14:45 -0500
Received: from pop.gmx.de ([213.165.64.20]:52751 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261576AbTCHBOo>;
	Fri, 7 Mar 2003 20:14:44 -0500
Message-ID: <3E692DEB.2030207@gmx.net>
Date: Sat, 08 Mar 2003 00:40:27 +0100
From: Christian <evilninja@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3b) Gecko/20030210
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_ALPHA_SRM not compiling on 2.5
References: <3E6538EF.3060602@gmx.net> <20030305005309.GM27794@lug-owl.de>
In-Reply-To: <20030305005309.GM27794@lug-owl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw schrieb:
>
> There seems to be a missing dependency then. Please ensure that you
> compile in the input subsystem core as well as virtual terminal support
> and support for console on virtual terminal.

oh, stupid me. yes, after selection input core support i was able to
select VT / console on VT support.

enabling this (and SRM), 2.5.63 compiled instantly.
but it won't boot now.

after typing "b" in SRM console (to start booting) and then after
choosing the kernel on the aboot (a boot loader) prompt, this is what i get:

-------
Starting kernel boot/2.5.63/vmlinux [....]
Linux version 2.5.63 #7 Wed Mar 05 [...]

halt code = 7
machine check while inPAL mode
PC = 14a0c
>>>
-------

hm, could be anything i guess. well, i'll have to google around a bit
and read even more...

Thank you,
Christian.

-- 
############ Christian ##############
########## c_kujau@web.de ###########
#####################################



