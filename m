Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVLILz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVLILz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 06:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVLILz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 06:55:27 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:10160 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751322AbVLILzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 06:55:25 -0500
Date: Fri, 9 Dec 2005 11:55:11 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jens Axboe <axboe@suse.de>
Cc: Erik Slagter <erik@slagter.name>, Jeff Garzik <jgarzik@pobox.com>,
       Randy Dunlap <randy_d_dunlap@linux.intel.com>, hch@infradead.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051209115511.GA25842@srcf.ucam.org>
References: <20051208134438.GA13507@infradead.org> <1134062330.1732.9.camel@localhost.localdomain> <43989B00.5040503@pobox.com> <20051208133144.0f39cb37.randy_d_dunlap@linux.intel.com> <1134121522.27633.7.camel@localhost.localdomain> <20051209103937.GE26185@suse.de> <1134125145.27633.32.camel@localhost.localdomain> <43996A26.8060700@pobox.com> <1134128127.27633.39.camel@localhost.localdomain> <20051209114641.GH26185@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209114641.GH26185@suse.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 12:46:42PM +0100, Jens Axboe wrote:
> On Fri, Dec 09 2005, Erik Slagter wrote:
> > I case this (still) isn't clear, I am addressing the attitude of "It's
> > ACPI so it's not going to be used, period".
> 
> The problem seems to be that you are misunderstanding the 'attitude',
> which was mainly based on the initial patch sent out which stuffs acpi
> directly in everywhere. That seems to be a good trigger for curt/direct
> replies.

I was just following the example set by the ide acpi suspend/resume 
patch, which people didn't seem to object to nearly as much. I guess 
IDE's such a hack anyway that people aren't as worried :) I'll try 
produce a patch that just inserts platform-independent code into scsi 
around the start of next week.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
