Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130900AbRDFCRM>; Thu, 5 Apr 2001 22:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130940AbRDFCRC>; Thu, 5 Apr 2001 22:17:02 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:30741 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130900AbRDFCQz>; Thu, 5 Apr 2001 22:16:55 -0400
Date: Thu, 5 Apr 2001 22:15:45 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@devserv.devel.redhat.com>
To: <ernte23@gmx.de>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at page_alloc.c:75! / exit.c
In-Reply-To: <3ACCBF2D.BA0F2037@gmx.de>
Message-ID: <Pine.LNX.4.33.0104052214310.20092-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001 ernte23@gmx.de wrote:

> "Albert D. Cahalan" wrote:
> >
> > > I'm running the 2.4.3 kernel and my system always (!) crashes when I try
> > > to generate the "Linux kernel poster" from lgp.linuxcare.com.au. After
> > > working for one hour, the kernel printed this message:
> >
> > I'd guess you have a heat problem. Check for dust, a slow fan,
> > an overclocked CPU, memory chips with airflow blocked by cables,
> > motherboard chips that are too hot to touch...

This is *not* a hardware problem.  We're tracking something fishy in the
vm code that is resulting in exactly the same BUG() tripping up on a
number of boxes (4 and 8 way SMP).

		-ben

