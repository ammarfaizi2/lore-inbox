Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266066AbRGGI1j>; Sat, 7 Jul 2001 04:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266067AbRGGI12>; Sat, 7 Jul 2001 04:27:28 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:16954 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266066AbRGGI1S>; Sat, 7 Jul 2001 04:27:18 -0400
Date: Sat, 7 Jul 2001 04:27:15 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Richard Chan <cshihpin@dso.org.sg>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: Athlon oops traced to CONFIG_MK7 code in arch/i386/lib/mmx.c
Message-ID: <20010707042715.B6815@devserv.devel.redhat.com>
In-Reply-To: <20010707091046.A2355@cshihpin.dso.org.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010707091046.A2355@cshihpin.dso.org.sg>; from cshihpin@dso.org.sg on Sat, Jul 07, 2001 at 09:10:46AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2001 at 09:10:46AM -0800, Richard Chan wrote:
> Athlon oops saga continues - I consistently get Athlon kernels oopsing
> during the boot up process either in rc.sysinit or loading of usb modules
> (this is a RedHat system 7.1). These kernels can boot to a shell init=/bin/sh
> but once I try to do stuff like inserting modules they oops left, right, and centre.
> 
What motherboard, how big is your PSU ?
This code has the tendency to get full memory-bandwidth and it appears that
some boards can't handle this....


Greetings,
   Arjan van de Ven
