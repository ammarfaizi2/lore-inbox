Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268431AbTBNPJd>; Fri, 14 Feb 2003 10:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268426AbTBNPJd>; Fri, 14 Feb 2003 10:09:33 -0500
Received: from bitmover.com ([192.132.92.2]:50342 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S268422AbTBNPJb>;
	Fri, 14 Feb 2003 10:09:31 -0500
Date: Fri, 14 Feb 2003 07:19:20 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Dillow <dillowd@y12.doe.gov>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 3Com 3cr990 driver release
Message-ID: <20030214151920.GA3188@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Dillow <dillowd@y12.doe.gov>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
References: <3E4C9FAA.FC8A2DC7@y12.doe.gov> <1045233209.7958.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045233209.7958.11.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 02:33:30PM +0000, Alan Cox wrote:
> On Fri, 2003-02-14 at 07:50, David Dillow wrote:
> > There are a few issues with the firmware -- DMA to a 2 byte aligned address
> > hangs the firmware, so we cannot easily align the IP header, and the firmware
> > will always strip the VLAN tags on packet reception, regardless of our
> > desires. I hope to work with 3Com to resolve these issues.
> > 
> > The code is available via BK at
> > http://typhoon.bkbits.net/typhoon-2.4
> > http://typhoon.bkbits.net/typhoon-2.5
> 
> Would you care to make the patches available in a format those of us who
> work on open source version control systems can use. Right now Mr McVoy
> prohibits me from reviewing your patches.

That seems a bit extreme, Alan.  I don't recall prohibiting you from anything
of the kind.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
