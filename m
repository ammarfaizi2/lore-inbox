Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbTE3XJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 19:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbTE3XJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 19:09:15 -0400
Received: from mail.ithnet.com ([217.64.64.8]:30468 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264045AbTE3XI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 19:08:57 -0400
Date: Sat, 31 May 2003 01:22:02 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Duncan Laurie <duncan@sun.com>
Cc: szepe@pinerecords.com, kwijibo@zianet.com, linux-kernel@vger.kernel.org
Subject: Re: 21rc6 serverworks IDE blows even more than is usual :)
Message-Id: <20030531012202.2c14ae77.skraw@ithnet.com>
In-Reply-To: <oprpzvr4xuury4o7@lists.bilicki.com>
References: <20030529114001.GD7217@louise.pinerecords.com>
	<20030529114001.GD7217@louise.pinerecords.com>
	<20030530121108.6a6a82de.skraw@ithnet.com>
	<oprpzvr4xuury4o7@lists.bilicki.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 09:51:30 -0700
Duncan Laurie <duncan@sun.com> wrote:

> On Fri, 30 May 2003 12:11:08 +0200, Stephan von Krawczynski <skraw@ithnet.com> wrote:
> >
> > I don't know if this is in anyway interesting for you, but I got the same
> > chipset on an Asus board and been burning GBs of data onto DVDs with it and no
> > (ide) problem.
> >
> 
> Its interesting to me.. It probably means my original diagnosis that this
> was a bad chip revision is unfounded and maybe it can be fixed with the
> right settings.  Could I get an lspci -xxx for devices 00:0f.0 and 00:0f.1
> from your box as well so I can cross-ref it with the broken ones?
> 
> -duncan

Just in case this should be needed:

lspci -xxx

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
00: 66 11 01 02 07 00 00 02 93 00 01 06 00 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 01 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 3a 1a 08 00 00 00 00 07 00 00 02 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 07 cb 53 3d 00 00 00 40 00 00 00 00
70: 0c 00 00 00 00 00 00 00 80 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 01 e8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 80 0e 00 00 88 0e 00 0c ff 0f 04 10 01 00 00 00
b0: 04 00 0c 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00: 66 11 12 02 15 00 00 02 93 8a 01 01 08 40 80 00
10: 01 a8 00 00 01 a4 00 00 01 a0 00 00 01 98 00 00
20: 01 94 00 00 00 00 00 00 00 00 00 00 66 11 12 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 99 99 99 20 ff ff ff 20 00 00 00 04 00 00 00 00
50: 00 00 00 00 04 00 00 02 0f 04 03 00 00 00 00 00
60: 00 00 00 00 fd ff 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Regards,
Stephan
