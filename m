Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288896AbSA2OMW>; Tue, 29 Jan 2002 09:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289191AbSA2OMM>; Tue, 29 Jan 2002 09:12:12 -0500
Received: from dhcp065-025-113-164.neo.rr.com ([65.25.113.164]:5886 "EHLO
	qfire.net") by vger.kernel.org with ESMTP id <S288896AbSA2OMC>;
	Tue, 29 Jan 2002 09:12:02 -0500
From: James Cassidy <jcassidy@qfire.net>
Date: Tue, 29 Jan 2002 09:11:58 -0500
To: Steven Hassani <hassani@its.caltech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sound Problems on Laptop
Message-ID: <20020129141158.GA23268@qfire.net>
In-Reply-To: <Pine.GSO.4.42.0201290052140.19357-100000@sue>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.42.0201290052140.19357-100000@sue>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Let me guess.... the Compaq Presario 700 series? Yes people
are aware that there is problem with sound on these machines.  There
are a few people trying to figure out what the problem is, but no
breakthrough yet has been made that I'm aware of.
	I think it's unlikely that the "volume buttons" actually
control anything in hardware. They are most probably just read
by some software in windows that then adjusts the volume. I think
the driver from compaq calls them Easy Access buttons or something
like that, I don't mess around in windows much anymore.  
	Also if you're using 2.4.17, if you are compiling with CPU
set to Athlon in the kernel config you'll want to be running one
of the 2.4.18pre kernels to correct a problem in the chipsets. You
can also get around this problem by selecting a lesser CPU in the
configuration. If you don't do either of these things you'll
quickly see Opps and programs randomly crashing when you start
to push your system.

						-- James (QFire)


On Tue, Jan 29, 2002 at 01:12:34AM -0800, Steven Hassani wrote:
> 	On a presario laptop (duron, 686b etc), I originally was unable to
> hear sound after loading the via sound module from 2.4.17 kernel.  After
> adjusting the mixer settings (using aumix) to the maximal possible
> settings, the sound became only barely noticeable.
> 	Just for further clarification, there also exists "volume
> adjustment keys" on the keyboard whose unusability may be something to
> blame....I don't know.
> 	Anyone have any thoughts?
> Steve
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
