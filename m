Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314460AbSDRVUG>; Thu, 18 Apr 2002 17:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314461AbSDRVUF>; Thu, 18 Apr 2002 17:20:05 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:54770
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314460AbSDRVUF>; Thu, 18 Apr 2002 17:20:05 -0400
Date: Thu, 18 Apr 2002 14:22:20 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/raid performance
Message-ID: <20020418212220.GH574@matchmail.com>
Mail-Followup-To: Helge Hafting <helgehaf@aitel.hist.no>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0204171108480.3300-100000@ns> <E16xrfQ-0002VF-00@the-village.bc.nu> <20020417102722.B26720@vger.timpanogas.org> <20020417134716.D10041@borg.org> <20020417232634.GC574@matchmail.com> <3CBE78A0.D5AD8AC2@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 09:41:20AM +0200, Helge Hafting wrote:
> Mike Fedyk wrote:
> 
> > I'd imagine that IDE would need some protocol spec changes before this could
> > be supported (at least a "spin the drive up" message...).
> > 
> Exists already.  You may use hdparm to tell IDE drives
> to spin up and down or even set a timeout.  This is
> mostly for power-saving or no-noise setups.
>

Oh yes, I know about that, but didn't remember it when I posted.

> So they could indeed add a jumper to IDE drives to let them
> power up in the spun-down state.  But that's not what
> the vast majority of one-disk users want.
> 

This is the specific thing I was talking about.  Even if the drive can power
down with a command, it doesn't wait for a command to perform the spinup
when power is applied, and that's what's missing.

It seems like there is already protocol support in IDE, so the drive just
needs a way to be configured...  Maybe some drives will allow software
config of this when they implement it?

