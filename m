Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTKLXAh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 18:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTKLXAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 18:00:37 -0500
Received: from www.wotug.org ([194.106.52.201]:31571 "EHLO ivimey.org")
	by vger.kernel.org with ESMTP id S261683AbTKLXAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 18:00:34 -0500
Message-ID: <3FB2BB7E.7090905@ivimey.org>
Date: Wed, 12 Nov 2003 23:00:14 +0000
From: Ruth Ivimey-Cook <ruth.ivimey-cook@ivimey.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jh@oobleck.astro.cornell.edu
CC: solt@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: Via KT600 support?
References: <200311111921.hABJLur16428@oobleck.astro.cornell.edu> <Pine.LNX.4.51.0311121016130.30003@dns.toxicfilms.tv> <200311121509.hACF9HG20967@oobleck.astro.cornell.edu>
In-Reply-To: <200311121509.hACF9HG20967@oobleck.astro.cornell.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Harrington wrote:

>Yes, thanks, I did that before I posted.  The problem exists with both
>the original BIOS (1004) and the latest (1005).
>
>Is anyone aware of similar problems with other manufacturers' KT600
>boards that were fixed in recent BIOS updates?  Perhaps Asus has a
>BIOS bug they haven't fixed yet.
>
>By the way, I also underclocked both the CPU and the memory as far
>down as they would go, just to check, and the problem persisted.
>  
>
I have an A7V600 too, with a Athlon 2100+. I found that the 2.4 kernel 
support (2.4.20 ... 22) was not up to it also, and switched to try the 
2.6.0-t9 kernel; this has, so far, proved fairly stable, with the 
exception of a might_sleep problem on the plug-in PCI IEEE1394 card I have.

I noticed that, with 2.4, the kernel was treating the KT600 chipset as a 
KT400 chipset: I don't know if this has changed in later editions of 
2.4, but it seemed to be an undesireable thing to do, which partly 
prompted my shift to 2.6

I too tried updating the BIOS to 1005; it does seem to fix a power-up 
problem (originally the BIOS would sometimes claim that a hardware fault 
had happened which hadn't hapened) but there still seem to be issues 
with the SATA ports: drives on them are never listed in the BIOS boot 
sequence, and unless I do a cold-boot (i.e. cable-unplugged, not just 
'off') the SATA drives aren't visible at all to the BIOS or to Linux.

One of these days I'll get around to filing a bug report about the SATA 
stuff with ASUS. Should it make a difference, the drives I@m using are 
Seagate 7200.7 120GB/8MB.

Regards,

Ruth


