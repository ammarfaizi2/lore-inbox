Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131982AbRCVKo7>; Thu, 22 Mar 2001 05:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131983AbRCVKot>; Thu, 22 Mar 2001 05:44:49 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45512 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131982AbRCVKoc>;
	Thu, 22 Mar 2001 05:44:32 -0500
Message-ID: <3AB9D73F.6B0A56B2@mandrakesoft.com>
Date: Thu, 22 Mar 2001 05:43:11 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcnet32 compilation fix for 2.4.3pre6
In-Reply-To: <200103220638.HAA16050@green.mif.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz wrote:
> 
> Hi,
>   It looks like a not fully merged patch from Alan's tree:
> 
> drivers/net/net.o: In function `pcnet32_open':
> drivers/net/net.o(.text+0x3bb9): undefined reference to `is_valid_ether_addr'
> drivers/net/net.o: In function `pcnet32_probe1':
> drivers/net/net.o(.text.init+0x5fa): undefined reference to `is_valid_ether_addr'

Ouch, missed that.  Thanks for the patch.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
