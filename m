Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVLHVJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVLHVJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVLHVJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:09:47 -0500
Received: from mail.dvmed.net ([216.237.124.58]:22443 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932363AbVLHVJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:09:26 -0500
Message-ID: <4398A0F9.9050900@pobox.com>
Date: Thu, 08 Dec 2005 16:09:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominic Ijichi <dom@ijichi.org>
CC: Erik Slagter <erik@slagter.name>, Christoph Hellwig <hch@infradead.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>, randy_d_dunlap@linux.intel.com,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
References: <20051208030242.GA19923@srcf.ucam.org>  <20051208091542.GA9538@infradead.org>  <20051208132657.GA21529@srcf.ucam.org>  <20051208133308.GA13267@infradead.org>  <20051208133945.GA21633@srcf.ucam.org>  <20051208134438.GA13507@infradead.org> <1134062330.1732.9.camel@localhost.localdomain> <43989B00.5040503@pobox.com> <1134075808.43989fa0e0404@www.ijichi.org>
In-Reply-To: <1134075808.43989fa0e0404@www.ijichi.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Dominic Ijichi wrote: > Quoting Jeff Garzik
	<jgarzik@pobox.com>: > > >>Erik Slagter wrote: >> >>>'guess You're not
	interested in having suspend/resume actually work on >>>laptops (or
	other PC's). That's your prerogative but imho it's a bit
	>>>narrow-minded to withhold this functionality from other people who
	>>>actually would like to have this working, just because you happen to
	not >>>like ACPI. >> >>It works just fine on laptops, with Jens'
	suspend/resume patch. > > > not on my fujitsu sonoma/ih6 based laptop
	it doesn't. in my travels trying to > fix this problem it appears there
	are many others it doesnt work for either. > suspend/resume is
	incredibly important for day-to-day practical use of a laptop, >
	particularly using linux. the sole reason i still have a windows
	partition is > because suspend doesnt work in linux and i'm sick of
	firing everything up again > 3 times a day. > > thank you very much to
	all on this list who are pursuing a solution sensibly and > not making
	unhelpful blanket statements against the most widely used laptop >
	chipset maker - *particularly* when they are actively contributing to >
	development on this list. we (laptop users) dont care about religious >
	standpoints, we just want it to work. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominic Ijichi wrote:
> Quoting Jeff Garzik <jgarzik@pobox.com>:
> 
> 
>>Erik Slagter wrote:
>>
>>>'guess You're not interested in having suspend/resume actually work on
>>>laptops (or other PC's). That's your prerogative but imho it's a bit
>>>narrow-minded to withhold this functionality from other people who
>>>actually would like to have this working, just because you happen to not
>>>like ACPI.
>>
>>It works just fine on laptops, with Jens' suspend/resume patch.
> 
> 
> not on my fujitsu sonoma/ih6 based laptop it doesn't.  in my travels trying to
> fix this problem it appears there are many others it doesnt work for either. 
> suspend/resume is incredibly important for day-to-day practical use of a laptop,
> particularly using linux. the sole reason i still have a windows partition is
> because suspend doesnt work in linux and i'm sick of firing everything up again
> 3 times a day.
> 
> thank you very much to all on this list who are pursuing a solution sensibly and
> not making unhelpful blanket statements against the most widely used laptop
> chipset maker - *particularly* when they are actively contributing to
> development on this list.  we (laptop users) dont care about religious
> standpoints, we just want it to work.

I've personally tested it on fuji ich5 and ich6 laptops.  What model do 
you have?  What kernel version did you test?  When did you apply the 
suspend/resume patch?

	Jeff



