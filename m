Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268873AbRG0Pz6>; Fri, 27 Jul 2001 11:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268872AbRG0Pzs>; Fri, 27 Jul 2001 11:55:48 -0400
Received: from abba.synaptique.co.uk ([213.86.145.226]:31611 "HELO
	host.domain.name") by vger.kernel.org with SMTP id <S268871AbRG0Pzb>;
	Fri, 27 Jul 2001 11:55:31 -0400
Date: Fri, 27 Jul 2001 16:55:33 +0100
From: Samuel Dupas <samuel@dupas.com>
To: sunny.zhou@wcom.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel paging request at virtual address 3b617b05 (was Re: swap_free: swap-space map bad (entry 00000100) )
Message-Id: <20010727165533.42aa0944.samuel@dupas.com>
In-Reply-To: <021a01c116b2$867aa960$689723a6@rcc05221.mcit.com>
In-Reply-To: <20010727162423.2fb6fc80.samuel@dupas.com>
	<021a01c116b2$867aa960$689723a6@rcc05221.mcit.com>
X-Mailer: Sylpheed version 0.5.0 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001 10:40:54 -0500
Sunny Zhou <sunny.zhou@wcom.com> wrote:
> Yesterday I got the same problem. I believe your hard disk is SCSI
> interface, and you are using 2.4.x kernel, right?


No, It's IDE disk, with software RAID, and the kernel is 2.2.19 (with some
patches to fill to a cobalt machine)

> I reduced my swapping space to 600MB and it worked(at least
> yesterday).
> Don't know why.

I think the problem might happen when I begin to use the swap. But it will
show that there are some problems on the disk.
For You, if it's a HDD problem, the "bad block" might be in the place of
the disk you are not using since you reduce youe partition.

But now, I don't know, Larry said that it might be the memory or the CPU,
now the HDD ...

There is not a specific event when the line "Unable to handle kernel
paging request at virtual address 3b617b05" is in the log ?

Thanks for your help

Samuel
