Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263927AbRF1TXt>; Thu, 28 Jun 2001 15:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263967AbRF1TXj>; Thu, 28 Jun 2001 15:23:39 -0400
Received: from [216.21.153.1] ([216.21.153.1]:50961 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S263927AbRF1TXa>;
	Thu, 28 Jun 2001 15:23:30 -0400
Date: Thu, 28 Jun 2001 12:25:09 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Patrick Dreker <patrick@dreker.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <3B3B7EC4.F4C8F2F0@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10106281224250.26067-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, Jeff Garzik wrote:

> Linus Torvalds wrote:
> > Things like version strings etc sound useful, but the fact is that the
> > only _real_ problem it has ever solved for anybody is when somebody thinks
> > they install a new kernel, and forgets to run "lilo" or something. But
> > even that information you really get from a simple "uname -a".
> > 
> > Do we care that when you boot kernel-2.4.5 you get "net-3"? No. Do we care
> > that we have quota version "dquot_6.4.0"? No. Do we want to get the
> > version printed for every single driver we load? No.
> > 
> > If people care about version printing, it (a) only makes sense for modules
> > and (b) should therefore maybe be done by the module loader. And modules
> > already have the MODULE_DESCRIPTION() thing, so they should NOT printk it
> > on their own.  modprobe can do it if it wants to.
> 
> As Alan said, driver versions are incredibly useful.  People use update
> their drivers over top of kernel drivers all the time.  Vendors do it
> too.  "Run dmesg and e-mail me the output" is 1000 times more simple for
> end users.

Why not a generic way to query the drivers for version info from
userspace?
 
	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

