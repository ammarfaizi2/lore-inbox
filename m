Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbSKYUvI>; Mon, 25 Nov 2002 15:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265650AbSKYUvI>; Mon, 25 Nov 2002 15:51:08 -0500
Received: from va.cs.wm.edu ([128.239.2.31]:59654 "EHLO va.cs.wm.edu")
	by vger.kernel.org with ESMTP id <S265351AbSKYUvH>;
	Mon, 25 Nov 2002 15:51:07 -0500
Date: Mon, 25 Nov 2002 15:58:18 -0500
From: Bruce Lowekamp <lowekamp@CS.WM.EDU>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: enabling AMD_PM768 causes boot hang in 2.4.20-rc3
Message-ID: <5410000.1038257898@chorus.cs.wm.edu>
In-Reply-To: <1038183180.28491.14.camel@irongate.swansea.linux.org.uk>
References: <6320000.1038078904@localhost.localdomain>
 <1038183180.28491.14.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/3.0.0a5 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, November 25, 2002 12:13:00 AM +0000 Alan Cox 
<alan@lxorguk.ukuu.org.uk> wrote:

> On Sat, 2002-11-23 at 19:15, Bruce Lowekamp wrote:
>>
>> With a dual-processor A7M266-D MB (two AMD XP-MP 1900+), enabling
>> CONFIG_AMD_PM768 causes the machine to hang on boot.
>>
>> I don't think this is a major concern for the release because the
>> description of this parameter includes EXPERIMENTAL (although it is not
>> flagged to be selectable on when experimental options are enabled).
>>
>> A few details:  The kernel is booted with noapic (has always hung
>> otherwise).  It hangs right after listing the drives and ide interfaces,
>> and right before it prints out the geometry of the first drive.  This is
>> the output prior to hanging:
>
> Does it work loaded as a module ?
>

Nope.  Got the prompt back and then it hung.

I put my .config online (temporarily) at 
http://www.cs.wm.edu/~lowekamp/amd_pm768-config if that helps diagnose 
anything.

Thanks,
Bruce


