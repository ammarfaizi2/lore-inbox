Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSKTV3K>; Wed, 20 Nov 2002 16:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262708AbSKTV3K>; Wed, 20 Nov 2002 16:29:10 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:12164 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262662AbSKTV3J>; Wed, 20 Nov 2002 16:29:09 -0500
Subject: Re: Semaphore and Shared memory questions...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Whittaker <rwhittak@gnat.nwtel.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.1.6.0.20021120131444.02482858@gnat.nwtel.ca>
References: <5.1.1.6.0.20021120131444.02482858@gnat.nwtel.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 22:04:49 +0000
Message-Id: <1037829889.5122.89.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 21:30, Richard Whittaker wrote:
> Part of building this machine up is tuning the kernel parameters for 
> shmmax, semmni, semmsl, semmns, etc...
> In reading, this should be fairly ieasy... Make some changes to 
> /usr/include/linux/sem.h and /usr/include/linux/shm.h, recompile, install, 
> LILO, reboot, and yer done... Well, my experience wasn't that simple...

Well if you insist on hacking code paths not using /proc Im not
suprised. You also probably ended up with a non oracle certified
platform by doing so (if that matters)

The sysctl interface and sysctl setting tools on boot exist precisely so
you dont have to hack these things around

Alan

