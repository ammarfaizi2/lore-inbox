Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTLDAVk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 19:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbTLDAVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 19:21:40 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:32901 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S262386AbTLDAVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 19:21:36 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Serial ATA (SATA) for Linux status report
Date: Thu, 4 Dec 2003 00:21:35 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bqlumf$gli$1@news.cistron.nl>
References: <20031203204445.GA26987@gtf.org> <1070494030.15415.111.camel@slurv.pasop.tomt.net> <3FCE737C.1080105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1070497295 17074 62.216.29.200 (4 Dec 2003 00:21:35 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FCE737C.1080105@pobox.com>,
Jeff Garzik  <jgarzik@pobox.com> wrote:
>Andre Tomt wrote:
>> On Wed, 2003-12-03 at 21:44, Jeff Garzik wrote:
>> 
>>>Intel ICH5
>>>----------
>>>Summary:  No TCQ.  Looks like a PATA controller, but with a few added,
>>>non-standard SATA port controls.
>
>> One question - with "including hotplug", does that mean some set hotplug
>> standard? Reason I'm asking is, we have a few servers from SuperMicro,
>> with a ICH5R S-ATA controller that claims it's supporting hotplug, but
>> hotplug is not in your ICH5-summary.
>
>Alas, there is no hotplug support in the ICH5 or ICH5-R SATA hardware.
>
>One could argue there is "coldplug" support in that hardware -- disable 
>the entire interface, including any active devices, then re-enable and 
>re-scan -- but it's a bit of a hack.  If there's enough demand, I could 
>write some code for that.

Please. Several vendors now have 1U boxes with 2 swappable SATA
drives, and many of those vendors (e.g. supermicro) use
motherboards with the ICH5 SATA chipset.

We're about to buy a few too, and we intend to use the drivers
in RAID0 mode. The ability to swap a drive without powering down
the whole box is quite essential.

Mike.

