Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144695AbRA2BLW>; Sun, 28 Jan 2001 20:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144751AbRA2BLK>; Sun, 28 Jan 2001 20:11:10 -0500
Received: from [62.2.247.131] ([62.2.247.131]:17674 "EHLO delouw.ch")
	by vger.kernel.org with ESMTP id <S144695AbRA2BK6> convert rfc822-to-8bit;
	Sun, 28 Jan 2001 20:10:58 -0500
Date: Mon, 29 Jan 2001 02:10:47 +0100 (CET)
From: Luc de Louw <luckyluke@delouw.ch>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.1-pre11
In-Reply-To: <Pine.LNX.4.10.10101281020540.3850-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101290201580.30638-100000@delouw.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

On Sun, 28 Jan 2001, Linus Torvalds wrote:


> 
> I just uploaded it to kernel.org, and I expect that I'll do the final
> 2.4.1 tomorrow, before leaving for NY and LinuxWorld. Please test that the
> pre-kernel works for you..

yes, it works :-)

> 
> The main noticeable things in pre11 are fixing some bugs that crept in
> after 2.4.0 - the block device queuing improvements could lose wakeups
> under extreme load by multiple clients, and the vmscanning "get rid of
> special return codes for shared memory" thing had missed a bit.
> 
> This should also fix the VIA IDE driver issues (if you want safe, do NOT
> enable auto-dma), and the reported problems with hpt366 controllers and
> IBM drives. Hopefully these were the last major IDE issues for a while.

It works fine for me

> 
> Also, can people who have had unhappy relationships with their eepro100
> please try to cuddle and make up again? The eepro100 changes should fix
> the problem of having posted writes that basically made some of the timing
> not work out.

I'll try that at monday ( In a couple of hours I'm at work) .....

> 
> 		Linus
> 

<snip>

Have a nice trip and enjoy NYC! weatherforcast for monday and wednesday
looks great, visit the empire state buiöding its gread (if you get the
time) I wish I could at LinuxWold too .... Have fun

rgds

Luc de Louw



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
