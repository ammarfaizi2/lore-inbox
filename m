Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290154AbSAKXDs>; Fri, 11 Jan 2002 18:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290157AbSAKXDi>; Fri, 11 Jan 2002 18:03:38 -0500
Received: from yeager.cse.Buffalo.EDU ([128.205.36.9]:751 "EHLO
	yeager.cse.Buffalo.EDU") by vger.kernel.org with ESMTP
	id <S290154AbSAKXDa>; Fri, 11 Jan 2002 18:03:30 -0500
Date: Fri, 11 Jan 2002 18:03:26 -0500 (EST)
From: Nelson Mok <nmok@cse.Buffalo.EDU>
To: Timothy Covell <timothy.covell@ashavan.org>
cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: SCSI ID wars [was:  USB Sandisk SDDR-31 problems in 2.4.9 -
 2.4.17]
In-Reply-To: <200201102237.g0AMbASr031936@svr3.applink.net>
Message-ID: <Pine.SOL.4.30.0201111755110.18542-100000@yeager.cse.Buffalo.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Timothy Covell wrote:

> On Thursday 10 January 2002 15:35, Matthew Dharm wrote:
> > The "stall at shutdown" is a known problem.  I'm testing a patch now... as
> > soon as I see my last patchset incorporated into the kernels, I'll send it
> > out for inclusion.
> >
> > As for the USB device "hiding" your SCSI device... how odd.   I've never
> > heard of that before.
> >
> > Matt
>
> Does it hide your SCSI device or just shift the SCSI IDs such that
> /dev/scd0 becomes /dev/scd1?
>
>
> And that brings up a question concerning whether there is a defined
> way of assigning SCSI IDs.    I'm assume that it's "every driver for
> itself".
>
>
> ---
> timothy.covell@ashavan.org.

Well after having this happen to me again, I checked to see whether the
SCSI IDs were shifted or not...  from what I gather, they haven't because
the CD-ROM is assigned ID 3 and the CD-R is assigned ID 4 and I am still
able to mount a CD as /dev/scd1 if the disc was placed in the CD-R drive.

