Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317734AbSFMPhF>; Thu, 13 Jun 2002 11:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317754AbSFMPhF>; Thu, 13 Jun 2002 11:37:05 -0400
Received: from LIGHT-BRIGADE.MIT.EDU ([18.244.1.25]:19983 "HELO
	light-brigade.mit.edu") by vger.kernel.org with SMTP
	id <S317734AbSFMPhD>; Thu, 13 Jun 2002 11:37:03 -0400
Date: Thu, 13 Jun 2002 11:36:59 -0400
From: Gerald Britton <gbritton@alum.mit.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Roberto Nibali <ratz@drugphish.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire Disks. (fwd)
Message-ID: <20020613113659.A21649@light-brigade.mit.edu>
In-Reply-To: <3D04EDC1.8010402@drugphish.ch> <Pine.LNX.3.95.1020613083727.1225A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 08:48:53AM -0400, Richard B. Johnson wrote:
> The firewire stuff apparently doesn't work too well on linux-2.4.18
> I have 3 SCSI disks plus a SCSI CD-R/W. The Adaptec Firewire controller
> has a 80 gig disk plus another CD-R/W attached. Both of these run fine
> (but slow) in W$.

The version in the kernel always crashed on me.  I've been having very good
success with the CVS versions at linux1394.sf.net though.  Only problems I've
been having are with leaving the kernel modules loaded (no 1394 hardware left
installed though) during a laptop suspend.. keyboard wasn't working on resume.
The disk and dvd+rw drive i have have worked flawlessly with the sbp2 driver
though.  And they do appear as normal scsi devices (they're announced when
the sbp2 driver loads, if you insert something later or remove something, you
have to do the scsi-add-single-device trick to rescan devices).

				-- Gerald

