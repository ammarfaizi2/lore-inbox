Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276483AbRJGRpS>; Sun, 7 Oct 2001 13:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276503AbRJGRpI>; Sun, 7 Oct 2001 13:45:08 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:8916 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S276483AbRJGRo4>; Sun, 7 Oct 2001 13:44:56 -0400
Message-ID: <3BC09483.8000401@korseby.net>
Date: Sun, 07 Oct 2001 19:44:35 +0200
From: Kristian Peters <kristian.peters@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: de, en
MIME-Version: 1.0
To: sven@uncivilised.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 VM problems burning CDs
In-Reply-To: <4345806.1002450485849.JavaMail.root@172.16.100.50>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sven@uncivilised.com wrote:

> Hi all,
> 
> I've found that when I try to burn a CD in 2.4.10 using cdrdao I get the lots of
> the following error:
> 
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012cd56
> This happens every time I burn a CD larger than about 300M. Sometimes 
> the OOM killer starts killing processes as well, but I haven't found a reliable
> way to reproduce this.


The vm of 2.4.10 is bad. I have the same problems with it. At the moment I'm 
using the -ac1 patch instead and everything works fine for me.


> 
> I get no errors using 2.4.9, or if I use cdrecord instead of cdrdao.
> 
> Regards,
> Steven



-- 
·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
                          :: http://www.korseby.net
                          :: http://www.tomlab.de
kristian@korseby.net ....::

