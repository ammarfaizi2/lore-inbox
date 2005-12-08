Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVLHVeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVLHVeQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVLHVeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:34:16 -0500
Received: from buffy.ijichi.org ([213.161.76.94]:48332 "EHLO buffy.ijichi.org")
	by vger.kernel.org with ESMTP id S932299AbVLHVeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:34:14 -0500
Message-ID: <1134077643.4398a6cb5bc78@www.ijichi.org>
Date: Thu, 08 Dec 2005 21:34:03 +0000
From: Dominic Ijichi <dom@ijichi.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Erik Slagter <erik@slagter.name>, Christoph Hellwig <hch@infradead.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>, randy_d_dunlap@linux.intel.com,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
References: <20051208030242.GA19923@srcf.ucam.org>  <20051208091542.GA9538@infradead.org>  <20051208132657.GA21529@srcf.ucam.org>  <20051208133308.GA13267@infradead.org>  <20051208133945.GA21633@srcf.ucam.org>  <20051208134438.GA13507@infradead.org> <1134062330.1732.9.camel@localhost.localdomain> <43989B00.5040503@pobox.com> <1134075808.43989fa0e0404@www.ijichi.org> <4398A0F9.9050900@pobox.com>
In-Reply-To: <4398A0F9.9050900@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Priority: 3 (Normal)
X-Originating-IP: 81.178.118.57
X-DSPAM-Result: Innocent
X-DSPAM-Confidence: 0.9997
X-DSPAM-Probability: 0.0000
X-DSPAM-Signature: 4398a6cf10811596913434
X-DSPAM-Factors: 27,
X-Spam-Score: -2.453
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeff Garzik <jgarzik@pobox.com>:

> Dominic Ijichi wrote:
> > Quoting Jeff Garzik <jgarzik@pobox.com>:
> >
> >
> >>Erik Slagter wrote:
> >>
> >>>'guess You're not interested in having suspend/resume actually work on
> >>>laptops (or other PC's). That's your prerogative but imho it's a bit
> >>>narrow-minded to withhold this functionality from other people who
> >>>actually would like to have this working, just because you happen to not
> >>>like ACPI.
> >>
> >>It works just fine on laptops, with Jens' suspend/resume patch.
> >
> >
> > not on my fujitsu sonoma/ih6 based laptop it doesn't.  in my travels trying
> to
> > fix this problem it appears there are many others it doesnt work for
> either.
> > suspend/resume is incredibly important for day-to-day practical use of a
> laptop,
> > particularly using linux. the sole reason i still have a windows partition
> is
> > because suspend doesnt work in linux and i'm sick of firing everything up
> again
> > 3 times a day.
> >
> > thank you very much to all on this list who are pursuing a solution
> sensibly and
> > not making unhelpful blanket statements against the most widely used laptop
> > chipset maker - *particularly* when they are actively contributing to
> > development on this list.  we (laptop users) dont care about religious
> > standpoints, we just want it to work.
> 
> I've personally tested it on fuji ich5 and ich6 laptops.  What model do
> you have?  What kernel version did you test?  When did you apply the
> suspend/resume patch?

N3510, 60gb sata model.  2.6.14,2.6.15-rc[1..5], with and without mm patches,
and various suspend patches sent to me by people on the linux-ide list.  in
particular, Jens Axboe's libata_suspend.patch and Randy Dunlap's patches here:
http://www.xenotime.net/linux/SATA/2.6.15-rc/, plus patches from your site:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/.  every
permutation and combination tried!  all with same result - laptop resumes but
hangs on first disk access.

cheers
dom


------------------------------------------
This message was penned by the hand of Dom
