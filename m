Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbSLPEDu>; Sun, 15 Dec 2002 23:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbSLPEDu>; Sun, 15 Dec 2002 23:03:50 -0500
Received: from smtp-server4.tampabay.rr.com ([65.32.1.43]:17915 "EHLO
	smtp-server4.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S264969AbSLPEDt>; Sun, 15 Dec 2002 23:03:49 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: "Robert Love" <rml@tech9.net>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: /proc/cpuinfo and hyperthreading
Date: Sun, 15 Dec 2002 23:13:17 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJEEKADLAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1040011359.3458.556.camel@phantasy>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> Yep, the 'siblings' value is the number of virtual processors in the
> physical package.
>
> Do you only see one processor listing in /proc/cpuinfo, though?  You
> should see one for each (virtual) processor.  That means two in a single
> HT-enabled P4, each with the same physical id.

That's what I expected!

> So it seems your chip works... is the kernel compiled for SMP?

Yup, it's compiled for SMP -- or, at least, I selected that option in make
menuconfig... ;) The boot reports:

Dec 15 11:51:18 Tycho kernel: Linux version 2.5.51 (root@Tycho)
                (gcc version 2.95.4 20011002 (Debian prerelease))
                #11 SMP Sat Dec 14 21:40:42 EST 2002

But later in the boot, it also states:

Dec 15 11:51:18 Tycho kernel: SMP motherboard not detected.

Something just doesn't look right about this.

..Scott

--
Scott Robert Ladd
Coyote Gulch Productions,  http://www.coyotegulch.com
No ads -- just very free (and somewhat unusual) code.

