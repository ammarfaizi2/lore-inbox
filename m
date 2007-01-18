Return-Path: <linux-kernel-owner+w=401wt.eu-S1752024AbXAROIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbXAROIu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 09:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbXAROIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 09:08:50 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:2457 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbXAROIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 09:08:50 -0500
Date: Thu, 18 Jan 2007 15:08:46 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: What does this scsi error mean ?
Message-ID: <20070118140846.GA30702@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Alan <alan@lxorguk.ukuu.org.uk>,
	"Hack inc." <linux-kernel@vger.kernel.org>
References: <20070115171602.GA23661@dspnet.fr.eu.org> <20070115184540.2b3c4f78@localhost.localdomain> <20070115214503.GA56952@dspnet.fr.eu.org> <20070115231452.3528bd32@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115231452.3528bd32@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 11:14:52PM +0000, Alan wrote:
> > Both smart and the internal blade diagnostics say "everything is a-ok
> > with the drive, there hasn't been any error ever except a bunch of
> > corrected ECC ones, and no more than with a similar drive in another
> > working blade".  Hence my initial post.  "Hardware error" is kinda
> > imprecise, so I was wondering whether it was unexpected controller
> > answer, detected transmission error, block write error, sector not
> > found...  Is there a way to have more information?
> 
> Well the right place to look would indeed have been the SMART data
> providing the drive didn't get into a state it couldn't update it.
> Hardware error comes from the drive deciding something is wrong (or a
> raid card faking it I guess). That covers everything from power
> fluctuations and overheating through firmware consistency failures and
> more.
> 
> If you pull the drive and test it in another box does it show the same ?

Ok, inverted the disks, got a crash of the same blade with the new
disk, so the problem is not the drive itself.  Gonna try inverting two
blades to check if it's the power supply connector/rail.

  OG.

