Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVLIL3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVLIL3W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 06:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVLIL3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 06:29:22 -0500
Received: from mail.dvmed.net ([216.237.124.58]:13232 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932157AbVLIL3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 06:29:20 -0500
Message-ID: <43996A84.5020307@pobox.com>
Date: Fri, 09 Dec 2005 06:29:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: Erik Slagter <erik@slagter.name>, Christoph Hellwig <hch@infradead.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>, randy_d_dunlap@linux.intel.com,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
References: <20051208030242.GA19923@srcf.ucam.org>	 <20051208091542.GA9538@infradead.org>	 <20051208132657.GA21529@srcf.ucam.org>	 <20051208133308.GA13267@infradead.org>	 <20051208133945.GA21633@srcf.ucam.org>	 <20051208134438.GA13507@infradead.org> <1134062330.1732.9.camel@localhost.localdomain> <43989B00.5040503@pobox.com> <4398F9E6.7000807@rtr.ca>
In-Reply-To: <4398F9E6.7000807@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Mark Lord wrote: > Jeff Garzik wrote: > >> Erik Slagter
	wrote: >> >>> 'guess You're not interested in having suspend/resume
	actually work on >>> laptops (or other PC's). That's your prerogative
	but imho it's a bit >>> narrow-minded to withhold this functionality
	from other people who >>> actually would like to have this working,
	just because you happen to not >>> like ACPI. >> >> >> >> It works just
	fine on laptops, with Jens' suspend/resume patch. >> >> Jeff > > > No.
	I use it on my two modern laptops with great success, > but only with
	*certain* hard disks. When I replace the ultra modern > 100GB drive in
	my machine with a slightly older 30GB drive, > suspend/resume no longer
	work. No other changes. > > Other users have reported similar
	experiences to me. > > We really REALLY need libata to get fixed for
	this stuff. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>> Erik Slagter wrote:
>>
>>> 'guess You're not interested in having suspend/resume actually work on
>>> laptops (or other PC's). That's your prerogative but imho it's a bit
>>> narrow-minded to withhold this functionality from other people who
>>> actually would like to have this working, just because you happen to not
>>> like ACPI.
>>
>>
>>
>> It works just fine on laptops, with Jens' suspend/resume patch.
>>
>>     Jeff
> 
> 
> No.  I use it on my two modern laptops with great success,
> but only with *certain* hard disks.  When I replace the ultra modern
> 100GB drive in my machine with a slightly older 30GB drive,
> suspend/resume no longer work.  No other changes.
> 
> Other users have reported similar experiences to me.
> 
> We really REALLY need libata to get fixed for this stuff.

Patches welcome :)  There is a bunch of stuff that needs to be done for 
suspend/resume.  Saving/restoring settings, additional resets and 
probes, etc.

	Jeff


