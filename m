Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbUJYMDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbUJYMDg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbUJYMDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:03:36 -0400
Received: from lucidpixels.com ([66.45.37.187]:33155 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261768AbUJYMDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:03:33 -0400
Date: Mon, 25 Oct 2004 08:03:32 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Kernel 2.6.9 Page Allocation Failures w/TSO+rollup.patch
In-Reply-To: <417CE49B.4060308@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0410250744440.9868@p500>
References: <Pine.LNX.4.61.0410250645540.9868@p500> <417CE49B.4060308@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It does not cause any noticable problems that I know of, I guess it is 
just a bit disturbing.

> Anyway, how often are you getting the messages? 
It depends what I am doing, sometimes they happen after 20-30 minutes, 
othertimes it takes a day or two.

> How many ethernet cards in the system?

There are 4 ethernet cards in the system.
1) 3c905b (on-board)
2) 3c905b (PCI)
3) 3c900 Combo (PCI)
4) Intel 82541GI/PI (PCI)

> Can you run a kernel with sysrq support, and do `SysRq+M`
> (close to when the allocation failure happens if possible, but
> otherwise on a normally running system after it has been up
> for a while). Then send in the dmesg.
Ok, I will try this.

On Mon, 25 Oct 2004, Nick Piggin wrote:

> Justin Piszcz wrote:
>> I guess people who get this should just stick with 2.6.8.1?
>> 
>
> Does it cause any noticable problems? If not, then stay with
> 2.6.9.
>
> However, it would be nice to get to the bottom of it. It might
> just be happening by chance on 2.6.9 but not 2.6.8.1 though...
>
> Anyway, how often are you getting the messages? How many
> ethernet cards in the system?
>
> Can you run a kernel with sysrq support, and do `SysRq+M`
> (close to when the allocation failure happens if possible, but
> otherwise on a normally running system after it has been up
> for a while). Then send in the dmesg.
>
> Thanks,
> Nick
>
