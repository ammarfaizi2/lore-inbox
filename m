Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290103AbSAQSLm>; Thu, 17 Jan 2002 13:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290107AbSAQSLc>; Thu, 17 Jan 2002 13:11:32 -0500
Received: from smtp-out1.kaptech.com ([62.106.132.133]:54802 "HELO
	smtp-out.kaptech.net") by vger.kernel.org with SMTP
	id <S290103AbSAQSLT>; Thu, 17 Jan 2002 13:11:19 -0500
User-Agent: Microsoft-Entourage/9.0.2.4011
Date: Thu, 17 Jan 2002 19:09:37 +0100
Subject: Re: aty128fb weirdness
From: Chris Boot <bootc@worldnet.fr>
To: <vda@port.imtp.ilyichevsk.odessa.ua>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <B86CD1F1.6BA%bootc@worldnet.fr>
In-Reply-To: <200201160817.g0G8HYE10520@Port.imtp.ilyichevsk.odessa.ua>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on 16/1/2002 13:17, Denis Vlasenko at vda@port.imtp.ilyichevsk.odessa.ua
wrote:

> On 15 January 2002 17:06, Chris Boot wrote:
>> I only just decided to reinstall Linux on my Apple iMac DV SE/500 with an
>> ATI Rage Pro 128.  Last time I used Linux on this machine was when kernel
>> 2.4.2 was the latest.  Now, when I try to use the native kernel driver for
>> my graphics card, all I get is a black screen.  I can type blindly into the
>> console or login through the network.  I double-checked all my kernel
>> arguments and didn't find any mistake whatsoever, and enabled the debug
>> code in the aty128fb driver, all to no avail.  I also tried several
>> kernels, ranging from the one included with my distro (a patched 2.4.10),
>> 2.4.16, 2.4.17, and 2.4.18-pre3.
> 
> You forgot to say which of them worked.

When I last used it it was 2.4.3 or something back then.

> Can't help you directly, but if nobody will answer, you can pinpoint at which
> kernel version exactly it broke. Don't forget to recompile them with same
> working .config from 2.4.2 (minus inevitable changes due to 'make oldconfig')
> if you will decide to go hunting the bug :-)

I stopped using Linux for a while and decided to install it over again and
found the video non-working (2.4.10), then I decided to upgrade and had the
same symptoms.  I had just recompiled a whole load of old kernels to see
under which it broke when all of a sudden I came across a web page stating
that acceleration didn't work on Rage 128 Pro chipsets, exactly what I have.
So I tried adding the "noaccel" kernel parameter (which I didn't used to
have to add) and it now works without a hitch under 2.4.18-pre3.  Go figure.

Thanks anyway,

-- 
Chris Boot
bootc@mac.com

"The keyboard is missing - Press any key to continue."

