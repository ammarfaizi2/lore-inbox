Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbWEYSlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWEYSlP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWEYSlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:41:15 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:3515 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030323AbWEYSlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:41:15 -0400
Date: Thu, 25 May 2006 20:40:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Kyle McMartin <kyle@mcmartin.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems
 to like Lordi...)
In-Reply-To: <Pine.LNX.4.64.0605250943520.5623@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr>
References: <20060525141714.GA31604@skunkworks.cabal.ca>
 <Pine.LNX.4.61.0605251829410.6951@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605250943520.5623@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 
>> As for extending the linux_banner, here's a real patch in my line...
>
>No, this sucks.
>
Read the subject (still contains Lordi) , so take this ("real") with a 
grain of salt.

>Sane configurations already have the FQDN as the hostname. It's quite 
>common to have "hostname" be the full name, and domainname be "(none)" 
>(with dnsdomainname being the domain name).
>
>I think your patch would make it say
>
>	torvalds@g5.osdl.org.osdl.org
>
>for me.
>
# cat /proc/version
Linux version 2.6.17-rc4 (jengelh@shanghai) (gcc version 4.1.0 (SUSE 
Linux)) #1 Sat May 20 00:06:16 CEST 2006
# hostname
shanghai
# hostname --fqdn
shanghai.hopto.org
# dnsdomainname
hopto.org

If the FQDN was already in the kernel, I would not have submitted this.
Frankly, the only that that I have not done was compile test it :)

>So just fix your hostname to give the full hostname. Nothing less makes 
>any sense anyway.
>
Oh in that case you just found a bug in suse linux.

>		Linus
>

Jan Engelhardt
-- 
