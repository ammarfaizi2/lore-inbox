Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVJKEP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVJKEP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 00:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVJKEP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 00:15:57 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:11846 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751246AbVJKEP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 00:15:57 -0400
Message-ID: <434B3C82.5080409@m1k.net>
Date: Tue, 11 Oct 2005 00:16:02 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Knecht <markknecht@gmail.com>
CC: Robert Crocombe <rwcrocombe@raytheon.com>, linux-kernel@vger.kernel.org
Subject: Re: PS/2 Keyboard under 2.6.x
References: <434B121A.3000705@raytheon.com> <5bdc1c8b0510101832v5f0c80d0ldec1ade4d4530292@mail.gmail.com>
In-Reply-To: <5bdc1c8b0510101832v5f0c80d0ldec1ade4d4530292@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Knecht wrote:

>On 10/10/05, Robert Crocombe <rwcrocombe@raytheon.com> wrote:
>  
>
>>I have a Microway system based around the Tyan Thunder K8QS Pro
>>motherboard (4x Opterons).  Under recent versions of 2.6:
>>
>>2.6.12
>>2.6.13
>>2.6.13.3
>>2.6.14-rc3-rt13
>>
>>the PS/2-connected keyboard becomes unresponsive once the kernel has
>>booted (I can use it to select which kernel to boot in grub -- actually,
>>it must be present to keep the system from whining and asking me to
>>press F1).  A USB keyboard works (I am composing this message from the
>>affected machine).  I attempted using earlier versions of the kernel,
>>but they do not compile before 2.6.12, and if you go far enough back
>>'make menuconfig' doesn't work (I found and fixed the minor error that
>>was reported, but haven't attempted to build those kernels again).
>>
>>    
>>
>
>I just reported this problem on the Gentoo bugzilla a couple of days
>ago. Here I have a P4HT machine. I had never turned on SMP to use the
>hyperthreading feature. When I turned it on I got exactly the problem
>you talk about. When I went back to UMP it worked fine.
>
>My keyboard is a wireless thing that had a little dongle to make it
>into ps2. I took that off and used the keyboard as a USB keyboard and
>it works fine under SMP.
>
>This was on 2.6.13-gentoo-r3 for me.
>
Have either of you tried the kernel boot option usb=handoff ?  I had 
similar problems, and this fixed it for me.

-- 
Michael Krufky

