Return-Path: <linux-kernel-owner+w=401wt.eu-S1751864AbWLNWQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbWLNWQo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWLNWQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:16:44 -0500
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:53895 "EHLO
	ccerelbas04.cce.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbWLNWQn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:16:43 -0500
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.19-git20 cciss: cmd f7b00000 timedout
Date: Thu, 14 Dec 2006 16:16:39 -0600
Message-ID: <E717642AF17E744CA95C070CA815AE55F6F0C3@cceexc23.americas.cpqcorp.net>
In-Reply-To: <20061214211207.GM25409@krebs.dannf>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-git20 cciss: cmd f7b00000 timedout
Thread-Index: AccfxHeq7KolEosYTf2fAvDRH4pCKwACL6QA
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Frazier, Daniel Kent" <daniel_frazier@hp.com>
Cc: "Jens Axboe" <jens.axboe@oracle.com>,
       "Steve Roemen" <stever@carlislefsp.com>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "ISS StorageDev" <iss_storagedev@hp.com>
X-OriginalArrivalTime: 14 Dec 2006 22:16:40.0609 (UTC) FILETIME=[878A4110:01C71FCD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Frazier, Daniel Kent 
> Sent: Thursday, December 14, 2006 3:12 PM
> To: Miller, Mike (OS Dev)
> Cc: Jens Axboe; Steve Roemen; LKML; ISS StorageDev
> Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
> 
> On Thu, Dec 14, 2006 at 01:44:34PM -0600, Miller, Mike (OS Dev) wrote:
> >  
> > 
> > > -----Original Message-----
> > > From: Jens Axboe [mailto:jens.axboe@oracle.com]
> > > Sent: Thursday, December 14, 2006 12:51 PM
> > > To: Steve Roemen
> > > Cc: LKML; ISS StorageDev; Miller, Mike (OS Dev)
> > > Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
> > > 
> > > On Thu, Dec 14 2006, Steve Roemen wrote:
> > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > Hash: SHA1
> > > > 
> > > > All,
> > > >     I tried out the 2.6.19-git20 kernel on one of my 
> machines (HP 
> > > > DL380 G3) that has the on board 5i controller (disabled),
> > > > 2 smart array 642 controllers.
> > > > 
> > > > I get the error (cciss: cmd f7b00000 timedout) with Buffer
> > > I/O error
> > > > on device cciss/c (all cards, and disks) logical block 0, 1, 2, 
> > > > etc
> > > 
> > > I saw this on another box, but it works on the ones that I have. 
> > > Does
> > > 2.6.19 work? Any chance you can try and narrow down when it broke?
> > 
> > Jens/Steve:
> > We also encountered a time out issue on the 642. This one 
> is connected 
> > to an MSA500. Do either of you have MSA500? What controller 
> fw are you 
> > running? Check /proc/driver/cciss/ccissN.
> 
> fyi, we've been seeing this in Debian too (which is why Mike 
> added me to the CC list), and I've narrowed it down to the 
> 2TB patch that went into 2.6.19:
>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=402787

Hmmmm. Dann, did you see this on 32-bit Debian? I have this running in
the lab on x86_64 and ia64. Someone else was _supposed_ to test ia32 for
me. Dammit.

Jens/Steve:
Are your os'es 32-bit?

mikem


> --


> dann frazier | HP Open Source and Linux Organization
> 
