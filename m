Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272462AbRIKOvQ>; Tue, 11 Sep 2001 10:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRIKOvG>; Tue, 11 Sep 2001 10:51:06 -0400
Received: from pasky.ji.cz ([62.44.12.54]:10490 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S272467AbRIKOvD>;
	Tue, 11 Sep 2001 10:51:03 -0400
Date: Tue, 11 Sep 2001 16:51:23 +0200
From: Petr Baudis <pasky@pasky.ji.cz>
To: "s.srinivas" <srinivas.surabhi@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to see .so contents
Message-ID: <20010911165123.E28186@pasky.ji.cz>
Mail-Followup-To: "s.srinivas" <srinivas.surabhi@wipro.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B9E4E62.494FBAE4@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B9E4E62.494FBAE4@wipro.com>; from srinivas.surabhi@wipro.com on Tue, Sep 11, 2001 at 11:18:18PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Its a silly question i tried with all my friends but of no use.
> Could any one tell me how to know the contents(modules) that
> are contained in any .so (shared objects) file.
> 
> say for ex. for archive  file    ar  -t  .a file name     is used  .
nm? man nm, nm library.so


-- 

				Petr "Pasky" Baudis
.                                                                       .
#define BITCOUNT(x)     (((BX_(x)+(BX_(x)>>4)) & 0x0F0F0F0F) % 255)
#define  BX_(x)         ((x) - (((x)>>1)&0x77777777)                    \
                             - (((x)>>2)&0x33333333)                    \
                             - (((x)>>3)&0x11111111))
             -- really weird C code to count the number of bits in a word
.                                                                       .
My public PGP key is on: http://pasky.ji.cz/~pasky/pubkey.txt
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS d- s++:++ a--- C+++ UL++++$ P+ L+++ E--- W+ N !o K- w-- !O M-
!V PS+ !PE Y+ PGP+>++ t+ 5 X(+) R++ tv- b+ DI(+) D+ G e-> h! r% y?
------END GEEK CODE BLOCK------
