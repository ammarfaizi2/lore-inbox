Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132406AbRDKONr>; Wed, 11 Apr 2001 10:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132578AbRDKON2>; Wed, 11 Apr 2001 10:13:28 -0400
Received: from mx7.port.ru ([194.67.23.44]:52689 "EHLO mx7.port.ru")
	by vger.kernel.org with ESMTP id <S132406AbRDKONW>;
	Wed, 11 Apr 2001 10:13:22 -0400
From: info <5740@mail.ru>
To: John Jasen <jjasen@datafoundation.com>
Subject: Re: 2.4.3 compile error No 4
Date: Wed, 11 Apr 2001 17:59:23 +0400
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
In-Reply-To: <Pine.LNX.4.30.0104110947430.19243-100000@flash.datafoundation.com>
In-Reply-To: <Pine.LNX.4.30.0104110947430.19243-100000@flash.datafoundation.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01041118154201.30945@sh.lc>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Срд, 11 Апр 2001 в сообщении на тему "Re: 2.4.3 compile error No 4" Вы написали:
> On Wed, 11 Apr 2001, info wrote:
> 
> > OS: Mandrake 6.0RE
> > AMD K6-200 144 M
> > gcc 2.95.2-ipl3mdk
> >
> > # CONFIG_IPX_INTERN is not set
> > # CONFIG_SYSCTL is not set
> > CONFIG_HPFS_FS=y
> >
> > Compiler error message No 4:
> 
> this may be a stupid question, but are you doing a 'make clean' after
> changing config parameters?

Maybe it's is a stupid order, but I  do this:
1. untar kernel into /usr/src (there was no /linux subdirectory)
 2. copy my own config file (named config-k6) from old 2.4.0 source
tree (compiled and working - now I am on 2.4.0) 
3. make xconfig, load configuration from this file and then manually
check all parameters   
4 store configuration into new config-k6-1 file
5. press button "Save and exit"
6. make dep
7. make bzImage

When it was the first error, I done:
1.make clean
2. make mrproper
3. then load configuration from my "config-k6-1" file, change
paremeters, store configuration. save and exit, make dep, make
bzImage 

Because there was several cases with mistakes, on one step I repead
all procedure - rm -f -R linux/*, then untar source. No effect: error
on the same place.

By the vay.

I put a mistake in my first letter in distributive number:
nor 6.0, but Mandrake 7.0RE with latest updates.

And another thing. When I compiled 2.4.0, there was errors too. I
play with various config parameters and find the combination than
compiled without errors.
