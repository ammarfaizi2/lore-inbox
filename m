Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWGKSqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWGKSqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWGKSqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:46:54 -0400
Received: from terminus.zytor.com ([192.83.249.54]:31414 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751178AbWGKSqy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:46:54 -0400
Message-ID: <44B3F203.3020500@zytor.com>
Date: Tue, 11 Jul 2006 11:46:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Olaf Hering <olh@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       torvalds@osdl.org, klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org>	 <Pine.LNX.4.64.0606271316220.17704@scrub.home>	 <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru>	 <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com>	 <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org>	 <20060711171624.GA16554@suse.de> <44B3E7D5.8070100@zytor.com>	 <20060711181552.GD16869@suse.de>  <44B3EC5A.1010100@zytor.com> <1152644023.18028.43.camel@localhost.localdomain>
In-Reply-To: <1152644023.18028.43.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Maw, 2006-07-11 am 11:22 -0700, ysgrifennodd H. Peter Anvin:
>> You know how much code there is in glibc to make your /bin/ls still work?
> 
> A static linked pre libc 2.2 (thats libc not glibc) ls works fine today,
> as does a 0.98.5 era built rogue binary

Didn't work when I tried it, although that was a shared binary (and yes, 
I had the library there.)  I assumed mostly that ZMAGIC support had 
bitrotted -- even back in '95 there was a lot of problems with ZMAGIC 
binaries when ext2 block size was > 1K.

	-hpa

