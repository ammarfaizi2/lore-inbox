Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286987AbRL1T1b>; Fri, 28 Dec 2001 14:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286998AbRL1T1W>; Fri, 28 Dec 2001 14:27:22 -0500
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:33805 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S286987AbRL1T1F>;
	Fri, 28 Dec 2001 14:27:05 -0500
Mailbox-Line: From tmh@nothing-on.tv  Fri Dec 28 19:26:59 2001
Message-ID: <3C2CC783.7040406@nothing-on.tv>
Date: Fri, 28 Dec 2001 19:26:59 +0000
From: Tony Hoyle <tmh@nothing-on.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011224
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: lists.linux-kernel
To: Samuel Maftoul <maftoul@esrf.fr>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs + ipv6 hanging???
In-Reply-To: <3C2BCAED.2030908@nothing-on.tv> <20011228152228.A928@pcmaftoul.esrf.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Maftoul wrote:

> On Fri, Dec 28, 2001 at 01:29:17AM +0000, Tony Hoyle wrote:
> 
>>Kernel 2.4.17, gcc-2.95.4, mount 2.11n
>>
>>nfs clients seem to hang when ipv6 is on the machine.  No idea why...
>>the mount process gets stuck in 'D' state and the only way out is to
>>reboot.
>>
>>If I remove ipv6 from the box & perform exactly the same operations then 
>>it works perfectly.  The mount is definately using the ipv4 address (I 
>>don't think the portmapper/nfsd is ipv6 enabled anyway).
>>
> Not really sure about this: 
> I'm at work using SuSE 7.2 wich is shipped with a native IpV6 support
> and our nfs client / server works almost perfectly ( with low testing on
> gigabit ethernet machines I've got 26 MB/sec)
>         Sam

It started working after I did a 'make mrproper' on both the client & 
server and recompiled.  Still no idea why it broke in the first place..

Tony

