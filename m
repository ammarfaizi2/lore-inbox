Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277152AbRKFFVf>; Tue, 6 Nov 2001 00:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277143AbRKFFVZ>; Tue, 6 Nov 2001 00:21:25 -0500
Received: from corb.mc.mpls.visi.com ([208.42.156.1]:41943 "EHLO
	corb.mc.mpls.visi.com") by vger.kernel.org with ESMTP
	id <S276956AbRKFFVR>; Tue, 6 Nov 2001 00:21:17 -0500
Date: Mon, 5 Nov 2001 23:21:16 -0600
From: Ryan Hayle <hackel@walkingfish.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Poor IDE performance with VIA MVP3
Message-ID: <20011105232116.B21177@isis.visi.com>
In-Reply-To: <20011105005033.A10060@isis.visi.com> <Pine.LNX.4.10.10111051506270.13543-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10111051506270.13543-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Mon, Nov 05, 2001 at 03:10:01PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Nov, 2001 at 03:10:01PM -0500, Mark Hahn wrote:
> > I have a VIA MVP3 (VT82C586B) controller on my motherboard, and am
> 
> an inherently slow chipset, with at best 150 MB/s dram throughput.
> 
> > experiencing extremely poor performance with a Maxtor 20G
> > (52049U4) drive.  
> 
> 20G, 4 surfaces, 10G/platter generation, from around 2-3 years ago.
> (versus 40G/platter current gen.)
> 
> > It is an UDMA66-capable drive, but I'm only attempting
> > to use UDMA33 (with an 80-pin cable, as recommended).
> 
> nothing wrong with an 80-conductor cable, but it's not required
> for udma33.
> 
> > same behavior.  I was originally running with a 40-pin cable, and switched
> > it to the 80 to see if it might help, but it had no effect.  As some
> 
> is it <18", with both ends plugged in? 
> 
> > Cable Type:                   40w                 40w
> 
> hmm.

The cable is of standard length, which I believe is 18".  It came with the
drive.  I only have one drive plugged into it.  I thought it was odd tha
/proc/ide/via only showed the cable as 40w also, but I assumed that was
because my chipset doesn't know what 80-pin cables are...am I wrong?  In
any case, it's sounding more and more that there's not much I can do to
remedy this problem. :/  Oh well, I'm probably due for a motherboard
upgrade in any case.

Thanks,
Ryan
