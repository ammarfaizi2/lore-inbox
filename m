Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275980AbRJYSjI>; Thu, 25 Oct 2001 14:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275973AbRJYSi7>; Thu, 25 Oct 2001 14:38:59 -0400
Received: from [160.131.145.131] ([160.131.145.131]:30213 "EHLO W20303512")
	by vger.kernel.org with ESMTP id <S275963AbRJYSiw>;
	Thu, 25 Oct 2001 14:38:52 -0400
Message-ID: <00ee01c15d84$5e878310$839183a0@W20303512>
From: "Wilson" <defiler@null.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <1004013479.2597.50.camel@athlon1.hemma.se> <3BD80A32.16D618FD@mandrakesoft.com> <1004033467.1726.3.camel@athlon1.hemma.se>
Subject: Re: Network device problems
Date: Thu, 25 Oct 2001 14:39:22 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Thomas Svedberg" <thsv@bigfoot.com>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: <linux-kernel@vger.kernel.org>; <rgooch@atnf.csiro.au>
Sent: Thursday, October 25, 2001 2:11 PM
Subject: Re: Network device problems

> > > 
> > > Just updated to RedHat 7.2 and after compiling and starting my new
> > > kernel my network interfaces won't go up (not even lo), I get the
> > > following message:
> > > "ifup: Cannot send dump request: Connection refused".
> > 
> > Yep.  Newer initscripts from RedHat and Mandrake (and others?) require
> > CONFIG_NETLINK_DEV.  initscripts runs, IIRC, iproute, which in turn
> > requires the netlink device.
> > 

Here's the relevant portion of the RELEASE-NOTES document from RedHat 7.2:

"The initscripts now use /sbin/ip (from the iproute packages) for most
operations. /sbin/ip requires the netlink and netlink routing features
of the kernel to function properly; it is impossible to make use of
the kernel's full routing functionality without these features. If you
are building your own kernel, make sure that CONFIG_NETLINK and
CONFIG_RTNETLINK are enabled."

They accused us of suppressing freedom of expression.
This was a lie and we could not let them publish it.
-- Nelba Blandon, Nicaraguan Interior Ministry Director of Censorship



