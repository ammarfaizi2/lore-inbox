Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWBSBJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWBSBJp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 20:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWBSBJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 20:09:45 -0500
Received: from smtp.enter.net ([216.193.128.24]:45065 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S964799AbWBSBJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 20:09:44 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Sat, 18 Feb 2006 20:10:01 -0500
User-Agent: KMail/1.8.1
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, mj@ucw.cz,
       nix@esperi.org.uk, linux-kernel@vger.kernel.org, chris@gnome-de.org,
       axboe@suse.de
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <43F0A319.nailKUSXT33MZ@burner> <43F7257D.80400@tmr.com>
In-Reply-To: <43F7257D.80400@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602182010.02468.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 February 2006 08:47, Bill Davidsen wrote:
> Joerg Schilling wrote:
> >Martin Mares <mj@ucw.cz> wrote:
> >>Hello!
> >>
> >>>The main problem is that there is no grant that a new model will survive
> >>>a time frame that makes sense to implement support.
> >>
> >>I bet that it would take less time to implement this support than what
> >>you spend here by arguing and trying to prove you are the only sane
> >>person in the world. Unsuccessfully, of course.
> >
> >If memory serves me correctly, the current model is the 3rd incompatible
> > one offerend within less than 5 years.
>
> With that I agree. Not only does the interface change, the details
> within a given interface must change.


At this point I seem to have stumbled across a document that has what Joerg 
might be looking for Linux to introduce. It's available at t10.org and is a 
translation layer specification for OS's to use if they want to access ATA 
devices like SCSI ones.

Seems to me this wouldn't be a good or bad thing to add to the kernel. The 
problem is that introducing the layer and thereby unifying the SCSI and ATA 
busses into one namespace is a big task. I know I couldn't manage it, and 
don't think there are any people willing to take it on.

Introducing it would provide a standard interface, however.

DRH
