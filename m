Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUBBU7Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUBBU4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:56:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:3973 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266097AbUBBUyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:54:23 -0500
X-Authenticated: #4512188
Message-ID: <401EB8FA.2060108@gmx.de>
Date: Mon, 02 Feb 2004 21:54:18 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.6.1-rc1 and rc-3
References: <BF1FE1855350A0479097B3A0D2A80EE0020AEB18@hdsmsx402.hd.intel.com>	 <1075664953.2389.12.camel@dhcppc4>  <401E0E2C.8020708@gmx.de> <1075748372.2398.117.camel@dhcppc4> <401EB859.9090200@gmx.de>
In-Reply-To: <401EB859.9090200@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Len Brown wrote:
> 
>>>> handlers:
>>>> [<c02a6b50>] (ide_intr+0x0/0x190)
>>>> [<c03248c0>] (snd_intel8x0_interrupt+0x0/0x210)
>>>> Disabling IRQ #11
>>>> irq 11: nobody cared!
>>
>>
>>
>> dmesg -s40000 output (or serial console log if dmesg unavailable)
>> /proc/interrupts
> 
> 
> This is starting to get stupid: I tried recreating the oops with rc2 and 
> rc2-mm2, but this time they started up normal. Currently I am even using 
> a mm2 based kernel. But 2.6.2-rc3 still oopses. The problem is it 

BTW, the only maybe affecting thing I change in the meanwhileis using 
the newest nvidia binary driver 53.36. Could something of it survive to 
the next boot (without powering the machin down)? Or might above oops 
just be a timing issue?

Prakash
