Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265478AbRF2DXz>; Thu, 28 Jun 2001 23:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265483AbRF2DXo>; Thu, 28 Jun 2001 23:23:44 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:14485 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S265478AbRF2DXb>; Thu, 28 Jun 2001 23:23:31 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200106290322.EAA04600@mauve.demon.co.uk>
Subject: Re: Cosmetic JFFS patch.
To: linux-kernel@vger.kernel.org
Date: Fri, 29 Jun 2001 04:22:45 +0100 (BST)
In-Reply-To: <3B3B7EC4.F4C8F2F0@mandrakesoft.com> from "Jeff Garzik" at Jun 28, 2001 03:00:20 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Linus Torvalds wrote:
> > Things like version strings etc sound useful, but the fact is that the
> > only _real_ problem it has ever solved for anybody is when somebody thinks
> > they install a new kernel, and forgets to run "lilo" or something. But
> > even that information you really get from a simple "uname -a".
> > 
> > Do we care that when you boot kernel-2.4.5 you get "net-3"? No. Do we care
> > that we have quota version "dquot_6.4.0"? No. Do we want to get the
> > version printed for every single driver we load? No.

It would be nice to show driver version for every single non-stock
driver we load though.
Perhaps a list of versions in the stock kernel build, stored somewhere,
that shouldn't be patched by anyone, but only change with official releases.
At compile time, if the driver version string is different from the
'blessed' version, it prints it's version, and possibly more.

<snip>
> As Alan said, driver versions are incredibly useful.  People use update
> their drivers over top of kernel drivers all the time.  Vendors do it
> too.  "Run dmesg and e-mail me the output" is 1000 times more simple for
> end users.

