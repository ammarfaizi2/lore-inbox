Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132474AbRDEBLh>; Wed, 4 Apr 2001 21:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132503AbRDEBL1>; Wed, 4 Apr 2001 21:11:27 -0400
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:4874 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S132474AbRDEBLN>; Wed, 4 Apr 2001 21:11:13 -0400
Date: Wed, 4 Apr 2001 18:10:22 -0700
Message-Id: <200104050110.f351AMu20890@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.3 crashed my hard disk
In-Reply-To: <E14ksW8-0002Y7-00@the-village.bc.nu>
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.2.19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2001 20:00:29 +0100 (BST), Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>> Been running this configuration over more than 2 years now without such
>> major problems.
>> Could this be the cause?
> 
> Quite possibly. There are reasons we ignore bug reports from overclockers

Perhaps. But,

ide_dmaproc: chipset supported ide_dma_timeout func only: 14

is about the most ominous message one can receive from the IDE driver:

1. it's not in English, so it doesn't tell you jack
2. it's usually a sign of "mkfs + reinstall needed"
3. I've had it happen on Intel and VIA chipsets alike, 100% guaranteed
   non-overclocked
4. Andre has repeatedly claimed "he's fixed it", but experience in the
   field shows quite the contrary to be true
5. I have yet to see a coherent explanation from Andre as to what the
   message means, or what causes it.

So right now 2.4 + IDE (or 2.2 + IDE + Andre's patches) is not a combination 
I can trust my data to, unless everything is running in PIO mode. The latter
is usually way too slow for anything useful, other than maybe a pure router.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
