Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263384AbTDZKVr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 06:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTDZKVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 06:21:47 -0400
Received: from mux2.uit.no ([129.242.5.252]:49419 "EHLO mux2.uit.no")
	by vger.kernel.org with ESMTP id S263384AbTDZKVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 06:21:46 -0400
Date: Sat, 26 Apr 2003 12:33:56 +0200
From: Tobias Brox <tobias@stud.cs.uit.no>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: nfsroot.c + ipconfig.c (2.4.20)
Message-ID: <20030426123356.C12540@stud.cs.uit.no>
Reply-To: tobias@stud.cs.uit.no
References: <200304231510.h3NFAh430564@lgserv3.stud.cs.uit.no> <shs8yu1uqak.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <shs8yu1uqak.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Apr 23, 2003 at 06:33:39PM +0200
Organization: =?iso-8859-1?Q?University_of_Troms=F8?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Trond Myklebust - Wed at 06:33:39PM +0200]
>    ftp://ftp.uninett.no/pub/linux/docs/HOWTO/mini/NFS-Root

I'm pretty sure my problems stems from something fishy in the kernel
code, not simply because I don't know what I'm doing.

The FAQ above is not much up-to-date, either.  I have a creeping
feeling that the nfsroot feature is not much used together with the
more recent kernel versions, as most modern computers are equipped
with harddisks.  I'd like to hear success-stories from people that
have managed to do a diskless boot with a kernel of version 2.4.20 or
more recent.

According to a an earlier mail to this list (available at
http://www.geocrawler.com/archives/3/35/2001/6/0/6079479/ ) ipconfig
should be called from init/main.c:checksetup() - I can say for sure
that this does not take place, regardless of what options I feed the
kernel with.

In the 2.5.66-version of the kernel, the function above has been
renamed to obsolete_checksetup.

When booting up with 2.5.66, it also fails to load the network driver
in time.  I know I have compiled the right driver into the kernel (and
not as a module).

-- 
Check our new Mobster game at http://hstudd.cs.uit.no/mobster/
(web game, updates every 4th hour, no payment, no commercials)
