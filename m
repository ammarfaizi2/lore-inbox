Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRCGWKi>; Wed, 7 Mar 2001 17:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131232AbRCGWK3>; Wed, 7 Mar 2001 17:10:29 -0500
Received: from hera.cwi.nl ([192.16.191.8]:29891 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131230AbRCGWKW>;
	Wed, 7 Mar 2001 17:10:22 -0500
Date: Wed, 7 Mar 2001 23:09:49 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103072209.XAA126156.aeb@vlet.cwi.nl>
To: andre@linux-ide.org, fishman@panix.com, jdow@earthlink.net
Subject: Re: Microsoft ZERO Sector Virus, Result of Taskfile WAR
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick writes:

> That is not the case Joanne is pointing out.
> The SCSI low-level format glue performed by the HOST gets destroyed
> If you write to LBA Zero.  ATA only suffers the lose of the partition
> table and that can be recovered, but SCSI needs that information to know
> where everything else is on the drive.

Joanne Dow wrote:

> > Jens, and others, I have noted a very simple data killer technique that
> > at LEAST works on Quantum SCSI drives as of a couple years ago and some
> > other earlier drives I felt could be sacrificed to the test. You can write
> > as many blocks at once as SCSI supports to the drive as long as you do
> > *NOT* start at block zero. If you write more than 1 block to block zero
> > the drive becomes unformatted. The only recovery is to reformat the
> > drive. The data on the drive is lost for good.

Hm, it is not yet April 1st.
But then, Joanne keeps pet dragons, I believe.
Perhaps writing to sector 0 of a SCSI drive is harmless
in case one does not keep such animals?

Andries

