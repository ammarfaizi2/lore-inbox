Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVFYCDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVFYCDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 22:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbVFYCDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 22:03:20 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:37115 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262693AbVFYCDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 22:03:17 -0400
Message-ID: <42BCBB60.7000508@comcast.net>
Date: Fri, 24 Jun 2005 22:03:12 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
Subject: Re: 2.6.12 breaks 8139cp
References: <42B9D21F.7040908@drzeus.cx> <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx> <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx>
In-Reply-To: <42BB3428.6030708@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:

>Bjorn Helgaas wrote:
>
>  
>
>>Your 2.6.11 dmesg mentions the VIA IRQ fixup, but the 2.6.12 one
>>doesn't.  I bet something's broken there.
>>
>>Can you try the attached debugging patch?  And please collect the
>>output of lspci, too.
>> 
>>
>>    
>>
>
>I tried the attached patch and it had no effect. I also tried porting
>the 2.6.11 way of handling the VIA quirk but it didn't have any effect.
>I'll try a more complete port tomorrow (it was a bit of a hack this time).
>
>  
>
2.6.11-mm4 doesn't work. So i'm guessing 2.6.11 wont work either which 
may be why backporting it's via fixes didn't do anything.  I'm gonna try 
vanilla and if that by some crazy chance works, then it'll be fairly 
easy to see what change did it since mm has a nice Changelog.
