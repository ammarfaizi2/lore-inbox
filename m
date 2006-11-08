Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965916AbWKHPMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965916AbWKHPMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 10:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965904AbWKHPMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 10:12:52 -0500
Received: from smtpout08-04.prod.mesa1.secureserver.net ([64.202.165.12]:31903
	"HELO smtpout08-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S965916AbWKHPMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 10:12:51 -0500
Message-ID: <4551F3F0.5020405@seclark.us>
Date: Wed, 08 Nov 2006 10:12:48 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
Subject: Re: New laptop - problems with linux
References: <4551EC86.5010600@seclark.us> <1162997980.3138.332.camel@laptopd505.fenrus.org>
In-Reply-To: <1162997980.3138.332.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Wed, 2006-11-08 at 09:41 -0500, Stephen Clark wrote:
>  
>
>>Hi list,
>>
>>I just purchased a VBI-Asus S96F laptop Intel 945GM &  ICH7, with a Core 
>>2 Duo T560,0 2gb pc5400 memory.
>> From checking around it appeared all the
>>hardware was well supported by linux - but I am having major problems.
>>
>>
>>1. neither the wireless lan Intel pro 3945ABG or built in ethernet 
>>    
>>
>
>you can get the driver for this from ipw3945.sf.net
>
>  
>
>>RTL-8169C are detected and configured
>>    
>>
Could you propose any reason why it is not be configured? Can I force 
load a module to
make it work. It is a real pain without a enet conniection, since I have 
to ferry stuff on thumbdrive

>>2. the disk which is a 7200rpm Hitachi travelmate transfers data at 1.xx 
>>mb/sec
>>    according to hdparm. This same drive in my old laptop an HP n5430 with a
>>    850 duron the rate was 12-14 mb/sec.
>>    
>>
>
>it seems you're using your sata disk in legacy IDE compatibility mode,
>and not AHCI mode... usually there is a bios setting to switch this
>(but be careful, if you switch it without adding the ahci driver to your
>initrd your system won't boot)
>
>
>
>
>  
>
Actually this is a pata drive. This laptop provides a pata interface 
even though it has
sata in the ICH7 chipset.


-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



