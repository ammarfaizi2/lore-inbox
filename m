Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131627AbRC3SRj>; Fri, 30 Mar 2001 13:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131631AbRC3SR3>; Fri, 30 Mar 2001 13:17:29 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:29832 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131627AbRC3SRO>; Fri, 30 Mar 2001 13:17:14 -0500
Date: Fri, 30 Mar 2001 13:16:14 -0500
From: Tim Coleman <tim@epenguin.org>
To: linux-kernel@vger.kernel.org
Subject: Re: RTL8139 conflicting with hard drive?
Message-ID: <20010330131614.A744@tux.epenguin.org>
In-Reply-To: <20010330085208.A428@tux.epenguin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010330085208.A428@tux.epenguin.org>; from tim@epenguin.org on Fri, Mar 30, 2001 at 08:52:08AM -0500
X-PGP-Key: finger tim@beastor.epenguin.org
X-Operating-System: Linux 2.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2001 at 08:52:08AM -0500, Tim Coleman wrote:
> I'm having a problem with a NIC I tried to install this morning.
> The chip on the NIC says its an RTL-8139B (it's a generic brand
> NIC, and I didn't really need anything fancy).
> 
> When I install the NIC, and try to boot, the kernel complains
> about not being able to find the root device.  If I take it out,
> everything is fine.  I'm using kernel version 2.4.1, and my 
> motherboard is an Asus A7V.  
> 
> I already have one RTL-8139B NIC installed, and it's just fine.
> 
> I also noticed that the kernel seemed to detect it as an IDE
> controller, because two more IDE devices showed up in the boot
> messages.
> 
> What could cause this?  More importantly, what's a good remedy?

Sorry about posting that.  I figured out what I was doing wrong,
and everything works now.  The new NIC I put in was stealing the
hardware addresses used by my IDE controller.

A change to lilo.conf fixed everything.

-- 
Tim Coleman <tim@epenguin.org>                         [43.28 N 80.31 W]
Software Developer/Systems Administrator/RDBMS Specialist/Linux Advocate
University of Waterloo Honours Co-op Combinatorics & Optimization
"Go to Heaven for the climate, Hell for the company." -- Mark Twain

