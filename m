Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130438AbRCIG77>; Fri, 9 Mar 2001 01:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130441AbRCIG7t>; Fri, 9 Mar 2001 01:59:49 -0500
Received: from letterman.noris.net ([62.128.1.26]:39685 "EHLO mail1.noris.net")
	by vger.kernel.org with ESMTP id <S130438AbRCIG7g>;
	Fri, 9 Mar 2001 01:59:36 -0500
From: "Matthias Urlichs" <smurf@noris.de>
Date: Fri, 9 Mar 2001 07:59:08 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010309075908.Z8922@noris.de>
In-Reply-To: <1epyyz1.etswlv1kmicnqM%smurf@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1epyyz1.etswlv1kmicnqM%smurf@noris.de>; from smurf@noris.de on Fri, Mar 09, 2001 at 07:34:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Matthias Urlichs:
> On Wed, Mar 07 2001, Stephen C. Tweedie wrote:
> > SCSI certainly lets us do both of these operations independently.  IDE
> > has the sync/flush command afaik, but I'm not sure whether the IDE
> > tagged command stuff has the equivalent of SCSI's ordered tag bits.
> > Andre?
> 
> IDE has no concept of ordered tags...
> 
But most disks these days support IDE-SCSI, and SCSI does have ordered
tags, so...

Has anybody done speed comparisons between "native" IDE and IDE-SCSI?

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
-- 
Success is something I will dress for when I get there, and not until.
