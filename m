Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbSK2Uov>; Fri, 29 Nov 2002 15:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbSK2Uov>; Fri, 29 Nov 2002 15:44:51 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:40857 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267153AbSK2Uou>; Fri, 29 Nov 2002 15:44:50 -0500
Subject: Re: UDMA causes IDE corruption on Shuttle AK32L mobo (VIA KT266A),
	kernel 2.4.1[89]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jim Halfpenny <jimvin@lineone.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <1038600903.2074.2.camel@fox>
References: <1038600903.2074.2.camel@fox>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Nov 2002 21:24:38 +0000
Message-Id: <1038605078.14232.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-29 at 20:15, Jim Halfpenny wrote:
> I have seen the behaviour using the stock 2.4.18 kernel from Mandrake
> 8.2. and the 2.4.19 kernel from Mandrake 9.0:
> Linux version 2.4.19-16mdk (quintela@bi.mandrakesoft.com) (gcc version
> 3.2 (Mandrake Linux 9.0 3.2-1mdk)) #1 Fri Sep 20 18:15:05 CEST 2002

Vendor kernel reports generally ahould go to the vendor, because the
vendor kernels are often quite different from the base one.

> There are no log entries in /var/log/messages or /var/log/syslog when
> these faulty writes take place to indicate that there are any problems
> but copying a large file and checking it's md5sum shows it to be
> damaged.

UDMA data transfers are verified by hardware end to end. UDMA showing up
memory problems is not unknown, but thats only one possibility.

