Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSKGQqx>; Thu, 7 Nov 2002 11:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSKGQqx>; Thu, 7 Nov 2002 11:46:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24850 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261492AbSKGQqv>;
	Thu, 7 Nov 2002 11:46:51 -0500
Message-ID: <3DCA9A88.4060109@pobox.com>
Date: Thu, 07 Nov 2002 11:53:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: George France <france@handhelds.org>
CC: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>,
       axp-list mailing list <axp-list@redhat.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       rth@twiddle.net, ink@jurassic.park.msu.ru
Subject: Re: [PATCH] eliminate compile warnings
References: <20021106214705.A15525@Marvin.DL8BCU.ampr.org> <02110709222600.14483@shadowfax.middleearth>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George France wrote:
> On Wednesday 06 November 2002 16:47, Thorsten Kranzkowski wrote:
> 
>>Hello!
>>
>>My attempt to compile 2.5.46 with gcc 3.3 resulted in over 66% lines of the
>>form:
> 
> 
> You are brave sole. The bleeding edge cuts both ways.
> 
> 
>>xyz.c: warning: comparison between signed and unsigned
>>
>>This is a first step to eliminate those, covering arch/alpha. Most fixes
>>are obvious, but please check.
>>
>>BTW who is the current maintainer for Alpha issues? MAINTAINERS has no
>>entry :-/
> 
> 
> If there is no entry in the MAINTAINERS file, then it is Linus.  He did the Alpha port.
> The first foray of Linux outside of the Intel architecture was to the Alpha processor.
> The Alpha system came from the laboratories of the Digital Equipment Corp.  An engineer
>  from Digital (now HP) arranged for a loan of an Alpha server to Linus Torvalds
> for him to begin a port of Linux. This act of beneficence greatly accelerated the
> migration of Linux to other platforms.  Linus is still the MAINTAINER for Alpha to this day.
> He still has his loaner box from Digital.


Weeeellll....  If you want to go by the "if there is no listing in 
MAINTAINERS" rule, sure :)

Richard Henderson can be considered the current alphalinux kernel 
maintainer for 2.4.x and 2.5.x, though he gets help from Ivan Kokshaysky 
and Jay Estabrook, and a tiny bit of help from me too.

So at the very least, please make sure alpha kernel patches get CC'd to 
rth@twiddle.net and ink@jurassic.park.msu.ru.

	Jeff



