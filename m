Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312935AbSDCAvS>; Tue, 2 Apr 2002 19:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312995AbSDCAvJ>; Tue, 2 Apr 2002 19:51:09 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:35834
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312991AbSDCAvD>; Tue, 2 Apr 2002 19:51:03 -0500
Date: Tue, 2 Apr 2002 16:52:44 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Mark Cooke <mpc@star.sr.bham.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Raid5 resync slow with one linear array
Message-ID: <20020403005244.GE952@matchmail.com>
Mail-Followup-To: Mark Cooke <mpc@star.sr.bham.ac.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020402022822.GA961@matchmail.com> <Pine.LNX.4.44.0204020630140.1152-100000@pc24.sr.bham.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2002 at 06:35:29AM +0100, Mark Cooke wrote:
> Hi Mike,
> 
> Have you checked individual transfer rates to the drives / md devices ?

Each drive transfers 18-20MB/sec, and all have been tested with badblocks -w.

> 
> I saw (non-reproducible unfortunately) a bad-transfer rate between one 
> of my drives in an ide raid setup, where the drive was only pushing ~ 
> 2MB/sec, even after being explictly zapped with hdparm.  A power cycle 
> fixed it, and it hasn't happenned since.
> 

Hmm, I don't think I'm dealing with bad hardware.  All are SCA SCSI and tested.

> Did you try building it with different chunk sizes ?
>

No, my root filesystem is on this array.  I think 32k chunks are ok.

Mike
