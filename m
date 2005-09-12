Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVILWM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVILWM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVILWM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:12:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55977
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932294AbVILWMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:12:24 -0400
Date: Mon, 12 Sep 2005 15:12:30 -0700 (PDT)
Message-Id: <20050912.151230.100651236.davem@davemloft.net>
To: joebob@spamtest.viacore.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4325FADB.4090804@spamtest.viacore.net>
References: <4325F3D5.9040109@spamtest.viacore.net>
	<20050912.144107.37064900.davem@davemloft.net>
	<4325FADB.4090804@spamtest.viacore.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Bob Spamtest <joebob@spamtest.viacore.net>
Date: Mon, 12 Sep 2005 15:02:03 -0700

> David S. Miller wrote:
> >>agreed -- as far as i'm concerned the 32 bit libraries are there for 
> >>compatibility's sake and should be in /lib/compat/<subarch> instead of 
> >>/lib. the native libraries should be in /lib instead of /lib64. lib64 
> >>should just go away!
> > 
> > 64-bit isn't any more "native" than 32-bit on some 64-bit platforms.
> > 32-bit is the default and most desirable userland binary format on
> > sparc64 for example.  So 32-bit programs on sparc64 are as "native" as
> > 64-bit ones might be considered.
> 
> that's true, i had forgotten about the sparc64 case. it really does slow 
> down tremendously when used in pure 64 bit mode

PPC64 is the same, as well as a few others are likely to
be in this boat as well.  The only known exception where
64-bit is a true win is x86_64.

> i would imagine this not to be the case for most architectures though. 
> possibly hppa is the same way. anyone with mips64 and ppc64 hardware out 
> there have any input?

See above.
