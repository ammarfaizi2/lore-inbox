Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268401AbUHQUU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268401AbUHQUU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268407AbUHQUU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:20:29 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:63135 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S268401AbUHQUUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:20:16 -0400
Message-ID: <41226871.5080900@tlinx.org>
Date: Tue, 17 Aug 2004 13:20:01 -0700
From: "L. A. Walsh" <law@tlinx.org>
Organization: Tlinx Solutions
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Darren Williams <dsw@gelato.unsw.edu.au>
CC: Rahul Jain <rbj2@oak.njit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel recompilation error
References: <Pine.GSO.4.58.0408162058310.17241@chrome.njit.edu> <20040817044343.GA17796@cse.unsw.EDU.AU>
In-Reply-To: <20040817044343.GA17796@cse.unsw.EDU.AU>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep...if ya ever find yourself running on a no-loop back kernel -- first
thing to do is compile-up a new one with it enabled so you can make
new kernels! :-)

-l

Darren Williams wrote:

>Hi Rahul
>As a guess the kernel you are compiling on
>does not have loopback enabled and therefore
>you are seeing this message.
>
>I use to see this message on RH7 and 8 if
>I had no loopback device.
>
>Darren
>
>On Mon, 16 Aug 2004, Rahul Jain wrote:
>
>  
>
>>Hi,
>>
>>This is the first time I am seeing this error while recompiling the
>>kernel. Could someone plz explain what it means and how to fix it.
>>
>>I get this error message when I run the command 'make install'. Till this
>>point everything else works out properly.
>>
>>Error Message
>>-------------
>>All of your loopback devices are in use.
>>mkinitrd failed
>>
>>The commands run before this were
>>make mrproper
>>make menuconfig
>>make dep
>>make bzImage
>>make modules and
>>make modules_install
>>
>>Thanks,
>>Rahul.
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>--------------------------------------------------
>Darren Williams <dsw AT gelato.unsw.edu.au>
>Gelato@UNSW <www.gelato.unsw.edu.au>
>--------------------------------------------------
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

-- 
    In the marketplace of "Real goods", capitalism is limited by safety
    regulations, consumer protection laws, and product liability.  In
    the computer industry, what protects consumers (other than vendor
    good will that seems to diminish inversely to their size)?


