Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278314AbRJMPYW>; Sat, 13 Oct 2001 11:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278315AbRJMPYO>; Sat, 13 Oct 2001 11:24:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:49424 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S278314AbRJMPXx>; Sat, 13 Oct 2001 11:23:53 -0400
Message-ID: <3BC85AE7.80D340C8@evision-ventures.com>
Date: Sat, 13 Oct 2001 17:16:55 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups
In-Reply-To: <200110130120.f9D1K2L0024119@sleipnir.valparaiso.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> Jeff Garzik <jgarzik@mandrakesoft.com> said:
> 
> [...]
> 
> > I was pondering whether it was ok to unconditionally include the
> > lib/crc32.c code, regardless of need.  I am leaning towards "no," which
> > implies Makefile and Config.in rules which must be updated for each
> > driver that uses crc32.
> 
> It is easier in that case just to make it another module.

That will waste space due to page granularity.
