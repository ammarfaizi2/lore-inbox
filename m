Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSGUQy3>; Sun, 21 Jul 2002 12:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSGUQy3>; Sun, 21 Jul 2002 12:54:29 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:783 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S316512AbSGUQy3>; Sun, 21 Jul 2002 12:54:29 -0400
Date: Sun, 21 Jul 2002 17:23:40 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Adrian Bunk <bunk@fs.tum.de>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit
In-Reply-To: <1027258349.17234.85.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.30.0207211705220.701-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21 Jul 2002, Alan Cox wrote:

> One of the design goals of Unix is that the system does not think
> it knows better than the administrator.

What about the many hundred counter-examples (e.g. umount gives EBUSY,
kill can't kill processes in uninterruptible sleep, etc, etc)? Why the
system knows better then admin in these cases? Why just don't destroy
the data, crash the system as you suggest in your case? Why this
inconsistency?

	Szaka

