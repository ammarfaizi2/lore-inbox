Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310300AbSCMMW5>; Wed, 13 Mar 2002 07:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310306AbSCMMWr>; Wed, 13 Mar 2002 07:22:47 -0500
Received: from ip68-4-123-226.oc.oc.cox.net ([68.4.123.226]:49393 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S310300AbSCMMWb>; Wed, 13 Mar 2002 07:22:31 -0500
Subject: Re: USB-to-serial 2303
To: davidchow@shaolinmicro.com (David Chow)
Date: Wed, 13 Mar 2002 04:22:34 -0800 (PST)
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Reply-To: barryn@pobox.com
In-Reply-To: <1016020663.31918.10.camel@star8.planet.rcn.com.hk> from "David Chow" at Mar 13, 2002 07:57:42 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020313122234.2E6B789CBE@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, I've got a pl2303 adapter running 2.4.17 . I cannot write any
> commands to my modem but I still read "RING" with some corrupted output
> from my /dev/ttyUSB0 port. Is this driver still in beta or not working?
> I would like to get some hints thanks.

Hmmm... I use this driver on an almost-daily basis (it's hooked up to an
ISDN "modem" at 230.4Kbps since my cable modem service is often down) and
it seems to work perfectly for me. Some of its behavior was a bit odd
several releases back (2.4.11 or so??) but it's been stable for me for a
while now (probably since 2.4.14, if I had to guess).

The only suggestion I can think of is to make sure you're setting the
port's speed properly in whatever program you're using for the testing
(personally, I find minicom useful for this kind of stuff).

-Barry K. Nathan <barryn@pobox.com>
