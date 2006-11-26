Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757998AbWKZVhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757998AbWKZVhV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 16:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757999AbWKZVhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 16:37:21 -0500
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:63482
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1757998AbWKZVhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 16:37:19 -0500
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Alessandro Zummo'" <alessandro.zummo@towertech.it>
Cc: "'David Brownell'" <david-b@pacbell.net>,
       "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>, <akpm@osdl.org>,
       <linuxppc-dev@ozlabs.org>, <lethal@linux-sh.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       <ralf@linux-mips.org>, "'Andi Kleen'" <ak@muc.de>, <paulus@samba.org>,
       <rmk@arm.linux.org.uk>, <davem@davemloft.net>, <kkojima@rr.iij4u.or.jp>
Subject: RE: NTP time sync
Date: Sun, 26 Nov 2006 22:37:10 +0100
Message-ID: <00b301c711a3$07cf3530$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AccRkC9OWnoULn/iQuW+7C0u3/7EnQAEKhlw
In-Reply-To: <20061126202148.190d5b4b@inspiron>
X-OriginalArrivalTime: 26 Nov 2006 21:37:14.0313 (UTC) FILETIME=[09AEA390:01C711A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alessandro Zummo [mailto:alessandro.zummo@towertech.it] 
> Sent: den 26 november 2006 20:22
> To: Joakim Tjernlund
> 
> On Sun, 26 Nov 2006 12:04:54 +0100
> "Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:
> 
> > Looking at rtc-dev.c I don't see a MARJOR number assigned 
> to /dev/rtcN. Seems like
> > it is dynamically allocated to whatever major number that is free.
> > Is that the way it is supposed to be? How do I create a 
> static /dev/rtcN in my /dev
> > directory if the major number isn't fixed?
> > Maybe I am just missing something, feel free to correct me :)
> 
>  udev ;)
> 
>  the concept of static numbers is quite old...

Yes it is old, but is the old way unsupported now? I have an embedded target
which is using the old static /dev directory, do I need to make
it udev aware to use newer features like the rtc subsystem?

 Jocke

