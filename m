Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318698AbSHANfL>; Thu, 1 Aug 2002 09:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318748AbSHANfL>; Thu, 1 Aug 2002 09:35:11 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:17391 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318698AbSHANfL>; Thu, 1 Aug 2002 09:35:11 -0400
Subject: Re: [PANIC] APM bug with -rc4 and -rc5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy TARREAU <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020801133202.GA200@pcw.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
	<20020801121205.GA168@pcw.home.local>  <20020801133202.GA200@pcw.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 15:55:32 +0100
Message-Id: <1028213732.14865.50.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 14:32, Willy TARREAU wrote:
> > I observe a kernel panic at boot time if I set apm=power-off. OK with apm=off.
> > This is on an ASUS A7M266D with two Athlon XP 1800+. Since it works well on
> > 2.4.19-pre10, I'm recompiling intermediate versions to check which one brought
> > the problem.
> > 
> > This is rather strange, since the crash occurs in do_softirq, but 2 bytes after

I've only run -ac on the box (I need the IDE) and that has subtly
different APM code. I do not however understand why it has changed
behaviour. I could understand if it did it at the actual poweroff point
but not earlier

