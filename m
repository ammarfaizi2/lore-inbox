Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266598AbRGGWQY>; Sat, 7 Jul 2001 18:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266606AbRGGWQP>; Sat, 7 Jul 2001 18:16:15 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:29448 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S266598AbRGGWP6>;
	Sat, 7 Jul 2001 18:15:58 -0400
Date: Sun, 8 Jul 2001 00:15:52 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: arjan@fenrus.demon.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
Message-ID: <20010708001552.C10370@pcep-jamie.cern.ch>
In-Reply-To: <20010707235329.A10256@pcep-jamie.cern.ch> <m15J07v-000OzlC@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m15J07v-000OzlC@amadeus.home.nl>; from arjan@fenrus.demon.nl on Sat, Jul 07, 2001 at 11:00:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arjan@fenrus.demon.nl wrote:
> >> Would it be possible to use a cramfs image in vmlinux (i.e. real
> >> filesystem image, not an in-kernel-structures fs like ramfs), and map
> >> it directly from the kernel image (it would have to be suitably aligned,
> >> of course)?
> 
> > Yes that would work, and it would work on machines with less RAM too.
> > You would want to remove the cramfs filesystem code when you're done though.
> 
> Until you pxe-boot your kernel over the network........

I don't see a problem with that.  pxe-boot loads vmlinuz, kernel boots
and finds cramfs image inside itself.  Problem?

-- Jamie
