Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261818AbTCaTcd>; Mon, 31 Mar 2003 14:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbTCaTcd>; Mon, 31 Mar 2003 14:32:33 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:37518 "EHLO
	mta4.rcnstx.swbell.net") by vger.kernel.org with ESMTP
	id <S261818AbTCaTcc>; Mon, 31 Mar 2003 14:32:32 -0500
Message-ID: <3E889D34.3000303@pacbell.net>
Date: Mon, 31 Mar 2003 11:55:32 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Kallol Biswas <kallol.biswas@efi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: netchip's net2280 usb 2.0 device
References: <3E85CA77.2020301@pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> Hi,
> 
>>      We have been using the net2280 chip (usb 2.0) as a usb target
>> printer device. We have been seeing data corruption problems
>> during a bulk out transfer when data is taken out the device
>> quite slow.  The corruption size is only 4 bytes suggesting
>> a device problem. Is anyone using this chip and has anyone
>> encountered similar problem?
> 
> 
> I've certainly been using it ... there's a Linux driver for it,
> part of a "USB Gadget" framework that could support other such
> "target mode" hardware, at http://kernel.bkbits.net/~david-b
> for general use.  (Download from BK, the 2.5.64 patch doesn't
> include the net2280 driver and there's no 2.4 patch yet.  I'll
> send out an announcement soon, when I update the patches.)

Just done.  There are now patches for 2.4 and 2.5 kernels.


> I haven't run into that particular problem, but it sounds
> like it might be a known erratum ... have you asked NetChip, or
> checked the 14-March errata at their website?  They've been
> pretty responsive to my questions.

I have in mind particularly erratum 0106 ... which might have
been what was making my TTCP testing from working.  Well, at
least the latest code for that is now behaving.

- Dave



>> Is there any other 2.0 usb chip that can be used as a target mode
>> device?
> 
> 
> The net2280 is the only such chip I know of that talks PCI
> directly.  So it's particularly Linux-friendly:  it doesn't
> need special bus adapter hardware.
> 
> - Dave
> 
> 



