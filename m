Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbTCEV3p>; Wed, 5 Mar 2003 16:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbTCEV3o>; Wed, 5 Mar 2003 16:29:44 -0500
Received: from 101.24.177.216.inaddr.G4.NET ([216.177.24.101]:36816 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP
	id <S265008AbTCEV3m>; Wed, 5 Mar 2003 16:29:42 -0500
Date: Wed, 5 Mar 2003 16:39:43 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: Ben Collins <bcollins@debian.org>
cc: Sebastian Zimmermann <sebastian@expires1203.datenknoten.de>,
       ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
Subject: Re: ieee1394: sbp2: sbp2util_allocate_request_packet
In-Reply-To: <20030305212148.GB552@phunnypharm.org>
Message-ID: <Pine.LNX.4.44.0303051635300.3364-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon, Ben,

On Wed, 5 Mar 2003, Ben Collins wrote:

> On Wed, Mar 05, 2003 at 10:08:08PM +0100, Sebastian Zimmermann wrote:
> > I have a problem using an external firewire harddrive. When writing to
> > the disk (badblocks -w) I get an error message about every minute:
> > 
> > kernel: ieee1394: sbp2: sbp2util_allocate_request_packet - no packets
> > available!
> > kernel: ieee1394: sbp2: sbp2util_allocate_write_request_packet failed
> > kernel: ieee1394: sbp2: aborting sbp2 command
> > kernel: Write (10) 00 09 51 b4 4a 00 00 fe 00
> > 
> > This by itself is - except for small pauses once and then - no problem.
> > But when writing much data (dd for 40 GB), it gets worse after some
> > time:
> 
> This is fixed the patch I send against -pre5. You can use the
> branches/linux-2.4 directory in the repo as a direct replacement for
> drivers/ieee1394 in fact (www.linux1394.org).

	It looks like the download page
(http://www.linux1394.org/download.html) is out of date:

"See below for how to apply patches. 

                   patch for 2.2.16-2.2.19 (released 2001-05-27) 
                   patch for 2.4.2-2.4.4 (released 2001-05-22) 
                   No patch is needed for newer 2.4 kernels and 2.5. Get 
the latest version of this series or use svn."

	I couldn't find a branches directory in the nightly tarball 
link at http://www.linux1394.org/viewcvs/trunk/?root=Linux+IEEE-1394 .

	Obviously I'm doing something wrong. :-)
	Is there some page on linux1394 which contains either a tar of the 
current 2.4 tree or a the most recent patch against 2.4?
	My sincere thanks for all your work and help.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Note: This page is best viewed using Ham Explorer 4.0 or better
(if you can can have it) in a resolution of 8x6 folicals, blindfolded
and facing away from the monitor. Preferably with clothes on and a
member of the clergy present."
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------

