Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292370AbSBUNWR>; Thu, 21 Feb 2002 08:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292292AbSBUNWF>; Thu, 21 Feb 2002 08:22:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2829 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292368AbSBUNVx>;
	Thu, 21 Feb 2002 08:21:53 -0500
Message-ID: <3C74F46F.FEA6F63D@mandrakesoft.com>
Date: Thu, 21 Feb 2002 08:21:51 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <Pine.LNX.4.21.0202210011080.32476-100000@serv> <20020221125431.GB28759@codepoet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> I like this.  It's simple, its clean, and it keeps all the
> information in one spot.  I think we can go a bit farther here
> and add in a list of the .c files that enabling this feature
> should add to the Makefile (per the current
>     obj-$(CONFIG_FOO)            += foo.o
> stuff in the current Makefile).

Hey, you're skipping ahead to the cool chapters!

Seriously, yep, that's exactly where we eventually want to be:  all
config, makefile, and help text info in one place.  To add a new net
driver, I want to be able to simply add two files, driver.c and
driver.conf, and be done with it.

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
