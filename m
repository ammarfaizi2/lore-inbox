Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268434AbRHKQJG>; Sat, 11 Aug 2001 12:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268440AbRHKQI4>; Sat, 11 Aug 2001 12:08:56 -0400
Received: from sal.qcc.sk.ca ([198.169.27.3]:44306 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S268434AbRHKQIr>;
	Sat, 11 Aug 2001 12:08:47 -0400
Date: Sat, 11 Aug 2001 10:08:58 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel lockups on dual-Athlon board -- help wanted
Message-ID: <20010811100858.A11219@qcc.sk.ca>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010811062349.A1769@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010811062349.A1769@thyrsus.com>; from esr@thyrsus.com on Sat, Aug 11, 2001 at 06:23:49AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond <esr@thyrsus.com> wrote:
> 
> A. Lockups can be induced in either console or X mode.  A reliable way to 
>    induce them is to run `make clean' on an X tree (any sufficiently 
>    long-running command seems to do it).

This sounds like bad hardware.
 
> 6. Here's a weird one.  When the kernel is running, the power switch
>    has to be pressed down for 4 seconds to power down the machine.  But
>    during a lockup it powers down the machine instantly.

This is normal for ATX machines.  There's usually a BIOS setting
controlling whether the power switch is instant or delayed, but once the
software isn't running any more, it's always instant.
 
I really do think it's bad hardware -- CPU, mainboard, power supply, or
some combination of the above.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
