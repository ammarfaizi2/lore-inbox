Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272982AbRIIRNr>; Sun, 9 Sep 2001 13:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272929AbRIIRN1>; Sun, 9 Sep 2001 13:13:27 -0400
Received: from ip122-15.asiaonline.net ([202.85.122.15]:43188 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S272872AbRIIRNV>; Sun, 9 Sep 2001 13:13:21 -0400
Date: Mon, 10 Sep 2001 01:11:19 +0800 (HKT)
From: David Chow <davidtl@rcn.com.hk>
X-X-Sender: <davidtl@uranus.planet.rcn.com.hk>
To: faybaby <faybaby@enter.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9 modules + unresovled symbols
In-Reply-To: <00b301c1387b$a5b7bee0$0200a8c0@lazybrain.com>
Message-ID: <Pine.LNX.4.33.0109100055370.11973-100000@uranus.planet.rcn.com.hk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is also what I want to report to Linus, since the 2.4.0 kernel. Some
of the kernel modules (drivers) are not compatible to the kernel API. Such
as a SCSI controller driver PCI2000 PCI2220i and one of the V4L driver
modules, these modules not even get through the compiler, and how come no
one reporting this and fix them up from version to version? Since we are
now up to release 2.4.9, I think these compilation error will directly
effecting the image of Linux. I hope the module maintainer who heard this
message should take some action to fix them up. Or you might able to fix
them up by porting the old code to use the changed APIs, they are probably
using different function names or macros, I don't think there will be a
serious or big change. Just be patient and go through the compilation
error messages from gcc and get through them all. For your case it might
be the include files at your compile time is different from your running
version. Check them.

regards,

David Chow

 On Sat, 8 Sep 2001, faybaby wrote:

> Hello, I haven't had any trouble upgrading the kernel til now.
> the problem is this. i can't load 80% of the modules i compiled.
>
>
> I have tried alot of things. depmod -a depmod this, depmod that.
>
> i did rm -rf /lib/modules/2.4.9 & /usr/src/linux , rextracted the kernel,
> configured and compiled it. it boots fine, i just can't load anything.
> im running mandrake 7.2.
> i did make clean, make mrproper a few times that didnt help.
> i download 2.4.9 again and started over with the same results.
> I even downloaded 2.4.6 and tried it, but produced the same results.
> Im currently running 2.4.6 that works fine, .
>
> whats wrong and how do i fix it. thanks everyone
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

