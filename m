Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265635AbRFWFKn>; Sat, 23 Jun 2001 01:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265634AbRFWFKe>; Sat, 23 Jun 2001 01:10:34 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:40458 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265636AbRFWFKU>; Sat, 23 Jun 2001 01:10:20 -0400
Message-Id: <200106230510.f5N5AFU84386@aslan.scsiguy.com>
To: David Ford <david@blue-labs.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Fri, 22 Jun 2001 20:57:37 PDT."
             <3B3413B1.6040808@blue-labs.org> 
Date: Fri, 22 Jun 2001 23:10:15 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ok, here's the relevant output from 2.2.19.  In future emails, would 
>like all the information posted to the list or would you like URLs to 
>the text docs?

If you think the information is of interest to the list, I have no
problem with continueing our dialog there.

Embedded text or URLs, whichever is easier for you is fine by me.

>Linux version 2.2.19 (root@James) (gcc version 2.95.3 20010315 
>(release)) #1 Fri
> Jun 22 20:17:08 PDT 2001
>...

Could you, by chance, have a 440GX based system, perhaps even an Intel
Lancewood MB?  If this is the case, your problem has to do with the PCI
IRQ table on the MB and/or how Linux now interprets it (Alan Cox or Doug
Ledford may have more info on this issue since they have been tracking
it for RedHat).  A possible work around is to enable APIC I/O.

If you don't have such a system, can you provide the full dmesg as
well as lspci output for your system.  That combined with the driver
messages should help me figure this out.

--
Justin
