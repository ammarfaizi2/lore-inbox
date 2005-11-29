Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVK2Ez1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVK2Ez1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 23:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVK2Ez1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 23:55:27 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:61132 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1750756AbVK2Ez0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 23:55:26 -0500
Message-ID: <438BDF72.1000704@m1k.net>
Date: Mon, 28 Nov 2005 23:56:18 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: linux-kernel@vger.kernel.org, Gene Heskett <gene.heskett@verizon.net>
Subject: Re: cx88 totally fried in 2.6.15-rcX -was- Re: HD3000 - no NTSC via
 tuner
References: <200511282205.jASM5YUI018061@p-chan.krl.com>	<438BCCF9.1000606@m1k.net> <438BCE5F.7070108@m1k.net> <200511282340.46506.gene.heskett@verizon.net>
In-Reply-To: <200511282340.46506.gene.heskett@verizon.net>
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

Gene Heskett wrote:

>On Monday 28 November 2005 22:43, Michael Krufky wrote:
>  
>
>>Michael Krufky wrote:
>>    
>>
>>>Gene Heskett wrote:
>>>      
>>>
>>>>Like I said, complete instructions please so that we are on the same
>>>>page.  I still have the rc2-git6 tree that didn't work, so as my
>>>>script does a make clean, it should be easy enough to do with the
>>>>right instructions.  Like what dir in the kernel tree am I supposed
>>>>to be in when I issue the cvs checkout command etc.
>>>>        
>>>>
>>Oops.... I forgot to answer this question....
>>
>>It doesnt matter in what directory you are issuing the commands
>>below... Although you certainly should NOT issue these within your
>>kernel source, and you should be inside the newly-downloaded v4l-dvb
>>tree after you "cd" into it.  I recommend either doing this in your
>>~home directory, or in /usr/src
>>    
>>
>
>I built it in /usr/src, seemed to be ok ANAICT.  It just didn't work. 
>Bear in mind I have no ATSC signals out here in the West Virginia hills
>yet, all ntsc.  So I can't as yet test the ATSC side.
>
Very interesting...  This whole time I thought that your testing was 
using a VSB stream.

So, you're only talking about problems with analog NTSC?

It seems that I might be having a similar (but NOT the same) problem 
with my FusionHDTV3 Gold-T, but it has nothing to do with the kernel 
version.  Let me remind you that this card uses Thomson DDT 7611, and 
your card uses Thomson DDT 7610.  It simply doesnt work anymore, 
regardless of whether I am in Linux or Windows, no matter which kernel 
version.  Only digital ATSC (using QAM256) is working for me.

I will have to test NTSC using my FusionHDTV5 Gold, installed in my 
other box.  It doesnt have 2.6.15 installed right now.  I will wait for 
2.6.15-rc3 to propogate to the kernel.org mirrors before I install it, 
so this may take some time.  The other card, however, has a TUA6034 
tuner, inside an LG TDVS-H062F ... not the same tuner as you this time, 
but still a cx88 board.

Anyway, after 2.6.15-rc3 propogates and I get it installed, I'll let you 
know how my testing goes.  Would you do the same?

Cheers,

Mike
