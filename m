Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264806AbSKNJBB>; Thu, 14 Nov 2002 04:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264808AbSKNJBB>; Thu, 14 Nov 2002 04:01:01 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:13324 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264806AbSKNJBA>; Thu, 14 Nov 2002 04:01:00 -0500
Message-ID: <3DD367F4.F5C289DD@aitel.hist.no>
Date: Thu, 14 Nov 2002 10:08:04 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.47 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Jirka Kosina <jikos@jikos.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FW: i386 Linux kernel DoS
References: <BF9651D8732ED311A61D00105A9CA3150B45FB3C@berkeley.gci.com> 
	 <20021112233150.A30484@infradead.org> <1037146219.10083.15.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44-jikos1.0211140036240.26832-100000@twin.jikos.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jirka Kosina wrote:
[...]
> At the beginning I thought only kernels <= 2.4.18 were affected; but it
> appeared that both kernels 2.4.19 and 2.4.20-rc1 are vulnerable as well.
> The flaw seems to be related to the kernel's handling of the nested task
> (NT) flag inside a lcall7.

Ouch.  That one froze up 2.5.47, running from a user account.
I couldn't recover with sysrq, but I was able to
emergency remount-ro avoiding the bootup fsck's.

Helge Hafting
