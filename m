Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLBCsE>; Fri, 1 Dec 2000 21:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLBCrx>; Fri, 1 Dec 2000 21:47:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17426 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129340AbQLBCrt>;
	Fri, 1 Dec 2000 21:47:49 -0500
Date: Sat, 2 Dec 2000 02:17:10 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Jeff Dike <jdike@karaya.com>
Cc: "T. Camp" <campt@openmars.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mutliple root devs (take II)
Message-ID: <20001202021710.G2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.LNX.4.21.0012011529070.4856-100000@magic.skylab.org> <200012020104.UAA05273@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200012020104.UAA05273@ccure.karaya.com>; from jdike@karaya.com on Fri, Dec 01, 2000 at 08:04:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 08:04:52PM -0500, Jeff Dike wrote:
> boot memory allocator (see mm/bootmem.c).  In the arch that I'm most familiar 
> with (arch/um), that is usable from the beginning of start_kernel.  I don't 
> know about the other arches.

setup_arch does the necessary initialization on most architectures - you
might want to consider fixing UML to be consistent with them.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
