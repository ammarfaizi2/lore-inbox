Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSGQSQG>; Wed, 17 Jul 2002 14:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSGQSQG>; Wed, 17 Jul 2002 14:16:06 -0400
Received: from server1.mvpsoft.com ([64.105.236.213]:36324 "HELO
	server1.mvpsoft.com") by vger.kernel.org with SMTP
	id <S316217AbSGQSQF>; Wed, 17 Jul 2002 14:16:05 -0400
Message-ID: <3D35B66E.20604@mvpsoft.com>
Date: Wed, 17 Jul 2002 14:24:46 -0400
From: Chris Snyder <csnyder@mvpsoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020713
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel panics on bootup
References: <3D345AD7.1010509@mvpsoft.com>	<1026858432.1687.85.camel@irongate.swansea.linux.org.uk> 	<3D34956A.7030200@mvpsoft.com> <1026860686.1688.97.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Tue, 2002-07-16 at 22:51, Chris Snyder wrote:
> 
>>Thanks for the quick reply.  Would it be possible for me to get this 
>>working with only one processor, then?  The nosmp option doesn't let it 
>>boot.
> 
> 
> Firstly check if the BIOS has any kind of "OS" or "Intel MP" options. If
> it has an OS option try setting it to something Unixlike. 
> 
> Next build a completely non SMP kernel and see if that boots. Let me
> know what that one does because the SMP failure should not have been a
> crash regardless of what it found
> 

I poked around in the bios for any APIC settings or OS settings, and 
found none.  I also couldn't find any configuration utilities that would 
let me change any of those settings.  While playing around in the 
diagnostics that are included with the server, I did find that it failed 
an MP test.  That would explain rather nicely why it isn't working. 
I'll have to convince the boss to let me spend more money now, since 
even if I can get it booting, I don't want to be running a server with 
buggy hardware.  Unless you're interested in getting the kernel to boot 
on this thing, I'm not going to pursue this any further.  Thanks for 
your help.

