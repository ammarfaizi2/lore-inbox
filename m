Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSKTVkz>; Wed, 20 Nov 2002 16:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSKTVkz>; Wed, 20 Nov 2002 16:40:55 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:14980 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261664AbSKTVky>; Wed, 20 Nov 2002 16:40:54 -0500
Subject: Re: Semaphore and Shared memory questions...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Whittaker <rwhittak@gnat.nwtel.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.1.6.0.20021120133929.02485ae8@gnat.nwtel.ca>
References: <5.1.1.6.0.20021120131444.02482858@gnat.nwtel.ca>
	<5.1.1.6.0.20021120131444.02482858@gnat.nwtel.ca> 
	<5.1.1.6.0.20021120133929.02485ae8@gnat.nwtel.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 22:16:34 +0000
Message-Id: <1037830594.3267.94.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 21:42, Richard Whittaker wrote:
> At 10:04 PM 11/20/2002 +0000, Alan Cox wrote:
> 
> >The sysctl interface and sysctl setting tools on boot exist precisely so
> >you dont have to hack these things around
> 
> Allright... This is fine by me... One of my questions was (and still is), 
> what do I pass to sysctl for setting /proc/sys/kernel/sem?...
> 
> Setting shmmax was easy, since it's only a single hex value, but sem is 
> puzzling me... Is a space separated list of values going to work?...

Right first guess. Its mostly historical that it isnt 4 values.

