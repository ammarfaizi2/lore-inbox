Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbSKLCct>; Mon, 11 Nov 2002 21:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbSKLCct>; Mon, 11 Nov 2002 21:32:49 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:33666 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S266199AbSKLCcs>; Mon, 11 Nov 2002 21:32:48 -0500
Message-ID: <3DD069FD.9010908@ntlworld.com>
Date: Tue, 12 Nov 2002 02:39:57 +0000
From: Steven Newbury <lkml@ntlworld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Newbury <lkml@ntlworld.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at drivers/block/ll_rw_blk.c:1910! in 2.5.47
References: <3DD06673.7080907@ntlworld.com>
In-Reply-To: <3DD06673.7080907@ntlworld.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Newbury wrote:
> I have just tested kernel 2.5.47 on my RH8 system and have this oops.
> 
> System: Dual AthlonMP 1200Mhz, Tyan Thunder K7, 512Mb Registered ECC DDR 
> SDRAM
>     /    IDE Quantum FireballPlusAS40 (AMD on board IDE)
>     /opt    \
>     /home    |    RAID0 md devices on 4x Quantum Atlas U160
>     /usr    |    (onboard Adaptec SCSI CHANNEL A)
>     /var    /
> 
> Kernel compiled for K7 with rh8 gcc3.2-7

Never mind.  I have just spotted that this is already known and reported 
in message: raid-0 BUG in 2.5.46-bk4

