Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312375AbSC3DUb>; Fri, 29 Mar 2002 22:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312376AbSC3DUV>; Fri, 29 Mar 2002 22:20:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29711 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312375AbSC3DUO>;
	Fri, 29 Mar 2002 22:20:14 -0500
Message-ID: <3CA52E8F.C8D0E5F8@zip.com.au>
Date: Fri, 29 Mar 2002 19:18:39 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Jackson <jerj@coplanar.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] which kernel debugger is "best"?
In-Reply-To: <010b01c1d794$07c7c9b0$7e0aa8c0@bridge>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson wrote:
> 
> What are people using?

kgdb.  Tried kdb and (sorry, Keith), it's not in the same
league.  Not by miles.

>  neither kdb or kgdb appear to support
> 2.5.7 (kdb does 2.5.5)...

General answer to this is to go for a foray in
http://www.zip.com.au/~akpm/linux/patches/

Which turns up
	http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.7/kgdb.patch

> or do real men debug with prink() ?

I have done it both ways, extensively, for long periods.
The printk method is comically inefficient.  The amount
of transparency whch kgdb gives to kernel internals is
extraordinary.

-
