Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbRCFUXu>; Tue, 6 Mar 2001 15:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbRCFUXk>; Tue, 6 Mar 2001 15:23:40 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:36613 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129453AbRCFUX3>; Tue, 6 Mar 2001 15:23:29 -0500
Date: Tue, 6 Mar 2001 14:22:32 -0600
To: Jeremy Jackson <jerj@coplanar.net>
Cc: Jeremy <prrthd25@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: VFS: Cannot open root device
Message-ID: <20010306142232.C28368@cadcamlab.org>
In-Reply-To: <20010303011000.1832.qmail@web4203.mail.yahoo.com> <3AA04B88.9B4E5AF8@coplanar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3AA04B88.9B4E5AF8@coplanar.net>; from jerj@coplanar.net on Fri, Mar 02, 2001 at 08:40:24PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jeremy Jackson]
> try command 'man mkinitrd' under redhat for hints about initial
> ramdisk.

I have been puzzled about this for quite some time.  Why exactly does
everyone always recommend using 'mkinitrd' on Red Hat systems?  It
seems to me that if you are compiling a kernel for a specific server
anyway, it is a much more reliable proposition to just compile in
whatever drivers you need to boot.

initrd's are inherently clumsy and fragile, to my way of thinking.
I've always thought they should only be used to support diverse or
unknown hardware, or odd cases like crypto loopback root.  Are there
other advantages to 'mkinitrd' in the case of a custom kernel for a
single machine?

Peter
