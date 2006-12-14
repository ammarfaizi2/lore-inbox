Return-Path: <linux-kernel-owner+w=401wt.eu-S932818AbWLNUUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932818AbWLNUUx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932789AbWLNUUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:20:34 -0500
Received: from brick.kernel.dk ([62.242.22.158]:4213 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932784AbWLNUUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:20:33 -0500
Date: Thu, 14 Dec 2006 21:21:58 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: Steve Roemen <stever@carlislefsp.com>, LKML <linux-kernel@vger.kernel.org>,
       ISS StorageDev <iss_storagedev@hp.com>,
       "Frazier, Daniel Kent" <daniel_frazier@hp.com>
Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
Message-ID: <20061214202158.GJ5010@kernel.dk>
References: <20061214185112.GG5010@kernel.dk> <E717642AF17E744CA95C070CA815AE55F2DAEA@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E717642AF17E744CA95C070CA815AE55F2DAEA@cceexc23.americas.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14 2006, Miller, Mike (OS Dev) wrote:
>  
> 
> > -----Original Message-----
> > From: Jens Axboe [mailto:jens.axboe@oracle.com] 
> > Sent: Thursday, December 14, 2006 12:51 PM
> > To: Steve Roemen
> > Cc: LKML; ISS StorageDev; Miller, Mike (OS Dev)
> > Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
> > 
> > On Thu, Dec 14 2006, Steve Roemen wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > > 
> > > All,
> > >     I tried out the 2.6.19-git20 kernel on one of my machines (HP 
> > > DL380 G3) that has the on board 5i controller (disabled),
> > > 2 smart array 642 controllers.
> > > 
> > > I get the error (cciss: cmd f7b00000 timedout) with Buffer 
> > I/O error 
> > > on device cciss/c (all cards, and disks) logical block 0, 1, 2, etc
> > 
> > I saw this on another box, but it works on the ones that I have. Does
> > 2.6.19 work? Any chance you can try and narrow down when it broke?
> 
> Jens/Steve:
> We also encountered a time out issue on the 642. This one is connected
> to an MSA500. Do either of you have MSA500? What controller fw are you
> running? Check /proc/driver/cciss/ccissN.

I think the case I know about here is an MSA500 as well, I can check in
the morning.

-- 
Jens Axboe

