Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbSLSGfv>; Thu, 19 Dec 2002 01:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267545AbSLSGfv>; Thu, 19 Dec 2002 01:35:51 -0500
Received: from packet.digeo.com ([12.110.80.53]:7382 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267544AbSLSGfu>;
	Thu, 19 Dec 2002 01:35:50 -0500
Message-ID: <3E016A9F.52A4048@digeo.com>
Date: Wed, 18 Dec 2002 22:43:43 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Timothy D. Witham" <wookie@osdl.org>
CC: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
References: <200212181908.gBIJ82M03155@devserv.devel.redhat.com> <1040276082.1476.30.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Dec 2002 06:43:43.0897 (UTC) FILETIME=[F95DD890:01C2A729]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Timothy D. Witham" wrote:
> 
> Related thought:
> 
>   One of the things that we are trying to do is to automate
> patch testing.
> 
>   The PLM (www.osdl.org/plm) takes every patch that it gets
> and does a quick "Does it compile test".  Right now there
> are only 4 kernel configuration files that we try but we are
> going to be adding more.  We could expand this to 100's
> if needed as it would just be a matter of adding additional
> hardware to make the compiles go faster in parallel.

It would be valuable to be able to test that things compile
cleanly on non-ia32 machines.  And boot, too.

That's probably a lot of ongoing work though.
