Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261201AbRELIWB>; Sat, 12 May 2001 04:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261202AbRELIVw>; Sat, 12 May 2001 04:21:52 -0400
Received: from colorfullife.com ([216.156.138.34]:31244 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S261201AbRELIVg>;
	Sat, 12 May 2001 04:21:36 -0400
Message-ID: <3AFCF294.10A93DD6@colorfullife.com>
Date: Sat, 12 May 2001 10:21:40 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new version of singlecopy pipe
In-Reply-To: <3AFC36BA.B71FC470@colorfullife.com> <20010512020742.A1054@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> 
> On 05.11 Manfred Spraul wrote:
> >
> > Please test it.
> > The kernel space part should be ok, but I know that the
> > patch can cause deadlocks with buggy user space apps.
> >
> 
> I tried your patch on 2.4.4-ac8, and something strange happens.
> Untarring linux-2.4.4 takes a little time, disk light flashes,
> but no files appear on the disk (just 'Makefile', as you will see below).
> Doing a separate gunzip - tar xf works fine:
> 
> werewolf:~/soft/kernel# gtar zxf linux-2.4.4.tar.gz
> werewolf:~/soft/kernel# ls linux-2.4.4
> Makefile

Could you try if 'strace -f -F gtar zxf linux-2.4.4.tar.gz > /tmp/trace
2>&1' hangs?

If yes, please send me the strace.
--
	Manfred
