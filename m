Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264675AbUEJMxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264675AbUEJMxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 08:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264681AbUEJMxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 08:53:38 -0400
Received: from a25.t1.student.liu.se ([130.236.221.25]:64235 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S264675AbUEJMxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 08:53:36 -0400
Message-ID: <409F7B4C.6070204@drzeus.cx>
Date: Mon, 10 May 2004 14:53:32 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 1/4 MMC layer
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd be very happy to see MMC support getting into the vanilla kernel. 
I'm about to purchase a HP NX7010 which has a currently unsupported 
MMC/SD card reader. It is my intention to attempt to write a driver for 
this reader (a Winbond w83l518d) and it'll make it easier with the MMC 
routines already in the kernel.
Memory cards are beginning to replace floppys so the sooner linux has 
good support for them the better =)

Are there any reason SD[IO] is left out? From what I can gather the 
unencrypted parts of SD are in the open now. Am I missing something here?

Rgds Pierre Ossman

PS. I'm not subscribed to the kernel list at the moment so please cc any 
replies.

> *From:* Russell King (/rmk+lkml_at_arm.linux.org.uk/)
>
>Date:	Sun, 2 May 2004 15:52:26 +0100
>To: Linux Kernel List <linux-kernel@vger.kernel.org>
>
>  
>
> On Thu, Apr 29, 2004 at 01:48:24PM +0100, Russell King wrote:
> /> This patch adds core support to the Linux kernel for driving MMC /
> /> interfaces found on embedded devices, such as found in the Intel /
> /> PXA and ARM MMCI primecell. This patch does _not_ add support /
> /> for SD or SDIO cards. /
>
> As there haven't been any comments, can I assume that either people
> don't care, or people are happy for this to appear in Linus' tree?
>
> (I actually suspect its out of peoples minds having been buried by
> about 4 days of lkml.)
>
> Thanks. 8) 


