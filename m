Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262161AbSKCQX0>; Sun, 3 Nov 2002 11:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262158AbSKCQXZ>; Sun, 3 Nov 2002 11:23:25 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:30093 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262161AbSKCQXY>; Sun, 3 Nov 2002 11:23:24 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <Pine.GSO.4.21.0211030946300.25010-100000@steklov.math.psu.edu>
References: <Pine.GSO.4.21.0211030946300.25010-100000@steklov.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 16:50:59 +0000
Message-Id: <1036342259.29642.51.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 14:51, Alexander Viro wrote:
> No messing with chroot needed - just a way to irrevertibly turn off the
> ability (for anybody) to do mounts/umounts in a given namespace and ability
> to clone that namespace.  Then give them ramfs for root and bind whatever
> you need in there.  No breaking out of that, since there is nothing below
> their root where they could break out to...

mkdir foo
chroot foo
cd ../../../..
chroot .

Alan

