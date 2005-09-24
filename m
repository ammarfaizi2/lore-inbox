Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVIXTpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVIXTpt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 15:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVIXTps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 15:45:48 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:38084 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1750715AbVIXTpr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 15:45:47 -0400
Message-ID: <4335ACE9.7070009@rtr.ca>
Date: Sat, 24 Sep 2005 15:45:45 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, acpi-support@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Supporting ACPI drive hotswap
References: <20050924164823.GA24351@srcf.ucam.org> <20050924124050.1955c290.rdunlap@xenotime.net>
In-Reply-To: <20050924124050.1955c290.rdunlap@xenotime.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Do you know why the ahci driver won't load?

Undoubtedly the chip is being used in "combined mode",
to support a PATA ATAPI device on the second channel.

For that matter, the primary HD is probably actually PATA,
perhaps with a SATA bridge on the notebook M/B.

Very very common arrangement these days -- practically all
Sonoma Centrino chipset notebooks are set up like this.

Cheers
