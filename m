Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271132AbRHTNln>; Mon, 20 Aug 2001 09:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271094AbRHTNle>; Mon, 20 Aug 2001 09:41:34 -0400
Received: from femail36.sdc1.sfba.home.com ([24.254.60.26]:10467 "EHLO
	femail36.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271215AbRHTNlO>; Mon, 20 Aug 2001 09:41:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: "Samium Gromoff" <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.8/2.4.8-ac7 sound crashes
Date: Mon, 20 Aug 2001 06:40:58 -0700
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15YlfQ-000EZS-00@f5.mail.ru>
In-Reply-To: <E15YlfQ-000EZS-00@f5.mail.ru>
MIME-Version: 1.0
Message-Id: <01082006405800.00227@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 August 2001 02:48 am, Samium Gromoff wrote:
>         I do not know if this problem is reported already,
>     since i read lkml thru web-archive, with accompanying
> update delays.
>
>     2.4.8 dies after ~1/2 minute of mpg123 playback,
>     with tty switching freeze, and typing out
>     continuously (i`d say infinitely) call trace.
>
>         ac7 acts this way too, but before death
>     sound stalls *some* times, i then each time restart
>     the proggie which emits it. This pattern survives
>     4-5 stalls, after which - final trace dump.
>
>     gcc-2.95.3, sb16 - genuine, vanilla ac7, vanilla
>     2.4.8.

no problems like this for me.
GCC 2.95.3, SB16 "Value" (don't ask me why they named it that, it's just 
like a regular SB16 ISA as far as I can tell), vanilla 2.4.8, mpg123 is 
version 0.59r, says june 15th 1999, I'll see if there's a newer version. 
I also use XMMS and it works fine.

What motherboard are you using? is the SB16 PCI or ISA? if it's ISA do 
you have persistant DMA buffers enabled in the kernel? (not sure if that 
would cause this or not)
