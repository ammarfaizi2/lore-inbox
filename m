Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266548AbUFQPdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266548AbUFQPdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUFQPdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:33:08 -0400
Received: from vsmtp3alice.tin.it ([212.216.176.143]:14308 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S266548AbUFQPcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:32:10 -0400
Message-ID: <40D1B975.8090506@tin.it>
Date: Thu, 17 Jun 2004 17:32:05 +0200
From: HayArms <voloterreno@tin.it>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.7] AGP KT600 identified as CLE266
References: <40D1A282.7010006@tin.it> <20040617141310.GB19280@redhat.com>
In-Reply-To: <20040617141310.GB19280@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Thu, Jun 17, 2004 at 03:54:10PM +0200, HayArms wrote:
> > Hi all,
> > 
> > I've compiled vanilla kernel 2.6.7 just today, and I've noticed that my 
> > KT600 AGP chipset is identified ad CLE266 :
> > 
> > Linux agpgart interface v0.100 (c) Dave Jones
> > agpgart: Detected VIA CLE266 chipset
> > agpgart: Maximum main memory to use for agp memory: 438M
> > agpgart: AGP aperture is 256M @ 0xc0000000
>
>Can you apply this..
>http://www.codemonkey.org.uk/projects/bitkeeper/agpgart/agpgart-2004-06-17.diff
>
>on top, and see if it fixes itself ? There was a missing table
>entry, which could have caused all the subsequent entries
>to be off by one. (And CLE266 is the entry before the KT600)
>
>		Dave
>
>
>  
>
Thanks,  this patch seems to solve the problem , now my system is 
detected as :

Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT400/KT400A/KT600 chipset
agpgart: Maximum main memory to use for agp memory: 438M
agpgart: AGP aperture is 256M @ 0xc0000000


:)

Thanks again

Bye

Marcello
