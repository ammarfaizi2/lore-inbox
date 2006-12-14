Return-Path: <linux-kernel-owner+w=401wt.eu-S1750989AbWLNUCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWLNUCf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWLNUCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:02:35 -0500
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:47806 "EHLO
	ccerelbas04.cce.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbWLNUCe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:02:34 -0500
X-Greylist: delayed 1076 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 15:02:34 EST
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.19-git20 cciss: cmd f7b00000 timedout
Date: Thu, 14 Dec 2006 13:44:34 -0600
Message-ID: <E717642AF17E744CA95C070CA815AE55F2DAEA@cceexc23.americas.cpqcorp.net>
In-Reply-To: <20061214185112.GG5010@kernel.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-git20 cciss: cmd f7b00000 timedout
Thread-Index: AccfsKi0460R8wacS3y+S+vDF7u/KAABzhYg
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Jens Axboe" <jens.axboe@oracle.com>,
       "Steve Roemen" <stever@carlislefsp.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>,
       "ISS StorageDev" <iss_storagedev@hp.com>,
       "Frazier, Daniel Kent" <daniel_frazier@hp.com>
X-OriginalArrivalTime: 14 Dec 2006 19:44:35.0629 (UTC) FILETIME=[48A0CDD0:01C71FB8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Jens Axboe [mailto:jens.axboe@oracle.com] 
> Sent: Thursday, December 14, 2006 12:51 PM
> To: Steve Roemen
> Cc: LKML; ISS StorageDev; Miller, Mike (OS Dev)
> Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
> 
> On Thu, Dec 14 2006, Steve Roemen wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > All,
> >     I tried out the 2.6.19-git20 kernel on one of my machines (HP 
> > DL380 G3) that has the on board 5i controller (disabled),
> > 2 smart array 642 controllers.
> > 
> > I get the error (cciss: cmd f7b00000 timedout) with Buffer 
> I/O error 
> > on device cciss/c (all cards, and disks) logical block 0, 1, 2, etc
> 
> I saw this on another box, but it works on the ones that I have. Does
> 2.6.19 work? Any chance you can try and narrow down when it broke?

Jens/Steve:
We also encountered a time out issue on the 642. This one is connected
to an MSA500. Do either of you have MSA500? What controller fw are you
running? Check /proc/driver/cciss/ccissN.

mikem


> 
> --
> Jens Axboe
> 
> 
