Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271719AbRIJVEY>; Mon, 10 Sep 2001 17:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271718AbRIJVEO>; Mon, 10 Sep 2001 17:04:14 -0400
Received: from mout0.freenet.de ([194.97.50.131]:11494 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S271687AbRIJVEE>;
	Mon, 10 Sep 2001 17:04:04 -0400
Date: Mon, 10 Sep 2001 22:34:57 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: New SCSI subsystem in 2.4, and scsi idle patch
Message-ID: <20010910223457.A690@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0109101216030.14338-100000@frank.gwc.org.uk> <Pine.LNX.4.10.10109101007150.15736-100000@coffee.psychology.mcmaster.ca> <20010910093326.A30659@ferret.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
In-Reply-To: <20010910093326.A30659@ferret.dyndns.org>; from idalton@ferret.dyndns.org on Mon, Sep 10, 2001 at 09:33:26AM -0700
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001 at 09:33:26AM -0700, idalton@ferret.dyndns.org wrote:
> Noflushd can be useful in this case, though it needs a patch to
> include/linux/kernel_stat.h in order to work with more than one
> IDE disk. More information is at <http://noflushd.sourceforge.net>

Tweaking kernel_stat.h is no longer necessary if you're running recent ac.
Alan merged a patch that exposes significantly more devices to /proc/stat.
I haven't checked if it went into the 2.4.10 pres as well. Unfortunately, the
patch also slightly changed the meaning of some of the entries so you'll
need grab current noflushd-CVS to make it work on the second ide channel.
Still, you might prefer that to patching the kernel. :)

Regards,

Daniel.

-- 
	GNU/Linux Audio Mechanics - http://www.glame.de
	      Cutting Edge Office - http://www.c10a02.de
	      GPG Key ID 89BF7E2B - http://www.keyserver.net
