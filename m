Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289098AbSANWUz>; Mon, 14 Jan 2002 17:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289096AbSANWUu>; Mon, 14 Jan 2002 17:20:50 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:51984 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S289094AbSANWTp>; Mon, 14 Jan 2002 17:19:45 -0500
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
	the elegant solution)
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020114153844.A20537@thyrsus.com>
In-Reply-To: <20020114132618.G14747@thyrsus.com>
	<m16QCNJ-000OVeC@amadeus.home.nl> <20020114145035.E17522@thyrsus.com>
	<20020114213732.M15139@suse.de>  <20020114153844.A20537@thyrsus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 14 Jan 2002 16:18:26 -0600
Message-Id: <1011046709.18003.45.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-14 at 14:38, Eric S. Raymond wrote:
> Right now, neither lsmod nor the boot time messages  necessarily give you that 
> information.  lsmod only works if the driver is in fact a module.  My 
> /var/log/dmesg contains no message from the NIC on my motherboard.  And
> going from the driver to the config symbol isn't trivial even if you *have*
> the lsmod or dmesg information.  

Yes, getting the current used environment from the running kernel in a
simple way would be nice. Actually, I'm interested in trying out your
autoconfigurator, though I'll be one to go back to the config and look
it over. The Aunt Tillie scenario doesn't preclude the usefulness of an
autoconfig tool.

> Sure, Melvin could remember a whole bunch of state, or a whole bunch
> of rules for reconstructing it. But isn't sweating that kind of detail
> exactly what *computers* are for?  

Precisely. The Real Problem(TM) is there are more issues than initial
kernel configuration that effect the details the user installing a
kernel or device is required to know. For a real example of this -- Grip
fails to see an audio CD in my CDRW when ide-scsi is loaded, DVD
playback is also slower but I need ide-scsi so I can backup CD's from
one drive to another. Right now, if I want to do one or another task, I
need to reboot using different kernel command lines, with a script to
alter my /dev links so the relevant apps continue to work. For another,
some of my apps need to be poked and prodded when my USB webcam hops
from /dev/video1 to /dev/video0 depending on whether bttv was or not.

Fixing those bits will allow vendors to make better and easier choices
with supplied kernels, at which point initial kernel (auto)configuration
becomes less important. I guess it's part of what Linus calls growing to
have a "middle-aged" kernel.  

Anyway, I know it's not a zero sum game. We can't make Eric stop work on
one thing and make him do another. In what ways could an
autoconfigurator better work in today's environment? What could the
kernel do to make that job easier while not offending people too much?

Regards,
Reid

