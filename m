Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289733AbSAOOXV>; Tue, 15 Jan 2002 09:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289776AbSAOOXL>; Tue, 15 Jan 2002 09:23:11 -0500
Received: from [149.168.208.47] ([149.168.208.47]:33284 "EHLO
	ice.dpi.state.nc.us") by vger.kernel.org with ESMTP
	id <S289573AbSAOOXB>; Tue, 15 Jan 2002 09:23:01 -0500
Message-ID: <3C443A76.BDCB4454@hcssystems.com>
Date: Tue, 15 Jan 2002 09:19:34 -0500
From: Josh Wyatt <josh.wyatt@hcssystems.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19-6.2.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: "'Kernel-Mailingliste'" <linux-kernel@vger.kernel.org>
Subject: Re: Softdog support on non-x86
In-Reply-To: <E16K6eS-0002HR-00@the-village.bc.nu> <3C3DA9DC.D00C3C72@hcssystems.com> <20020111103423.A30436@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Thu, Jan 10, 2002 at 09:49:00AM -0500, Josh Wyatt wrote:
> > I'd like to use the software watchdog timer, softdog.c, on the Sparc
> > architecture, using kernel 2.2.17.  I used this to build the module:
> > cd /usr/src/linux-2.2.17/drivers/char
> > gcc -c -DMODVERSIONS -D__KERNEL__ -DMODULE -Wall -Wstrict-prototypes
> > softdog.c
> 
> Why are you building it manually?  It'd be better to turn it on
> using the configuration tools, and build it in the normal way?

Please CC: me as I am not on the list.

I built the module manually precisely because I did not want to rebuild
the entire kernel and module set just to get this one module.

Perhaps I do not understand the correct approach to building individual
modules, on an existing tree.

What's the documented, correct approach to only building a single
module, starting with menuconfig, such that it will happily fit in with
the currently running kernel and modules?  I notice that many
drivers/modules happily include the correct gcc incantation (in comment)
for doing exactly this, and many do not.

And finally, back to my original question, is it a mute point?  Is the
softdog an Intel-only thing?

Thanks,
josh


> 
> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
