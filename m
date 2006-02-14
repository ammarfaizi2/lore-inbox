Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbWBMXyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWBMXyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWBMXyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:54:04 -0500
Received: from smtp.enter.net ([216.193.128.24]:47112 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1030317AbWBMXyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:54:01 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Nix <nix@esperi.org.uk>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 13 Feb 2006 19:03:07 -0500
User-Agent: KMail/1.8.1
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, greg@kroah.com,
       davidsen@tmr.com, linux-kernel@vger.kernel.org, axboe@suse.de
References: <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <43F0891E.nailKUSCGC52G@burner> <871wy6sy7y.fsf@hades.wkstn.nix>
In-Reply-To: <871wy6sy7y.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131903.08327.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 17:14, Nix wrote:
> On Mon, 13 Feb 2006, Joerg Schilling stated:
> > Greg KH <greg@kroah.com> wrote:
> >> On Fri, Feb 10, 2006 at 04:06:39PM -0500, Bill Davidsen wrote:
> >> > The kernel could provide a list of devices by category. It doesn't
> >> > have to name them, run scripts, give descriptions, or paint them blue.
> >> > Just a list of all block devices, tapes, by major/minor and category
> >> > (ie. block, optical, floppy) would give the application layer a chance
> >> > to do it's own interpretation.
> >>
> >> It does so today in sysfs, that is what it is there for.
> >
> > Do you really whant libscg to open _every_ non-directory file under /sys?
>
> Well, that would be overkill, but iterating across, say,
> /sys/class/scsi_device seems like it would be a good idea.
>
> (I doubt libscg would ever be interested in the stuff in most of the
> other directories: things like /dev/mem are not SCSI devices and never
> will be, and /sys/class/scsi_device contains *everything* Linux
> considers a SCSI device, no matter what transport it is on, SATA and
> all. However, I don't know if it handles IDE devices that you can SG_IO
> to because I don't have any such here. Anyone know?)

Not on my system, and I have a DVD-ROM and a CDRW drive attached, both of 
which are capable of SG_IO.

DRH
