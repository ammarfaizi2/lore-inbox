Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264601AbUD2OZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbUD2OZA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 10:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbUD2OY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 10:24:59 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:54940 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S264601AbUD2OYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 10:24:54 -0400
Message-ID: <40911034.4040404@tomt.net>
Date: Thu, 29 Apr 2004 16:24:52 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [sata] new driver -- AHCI
References: <408C1F41.3060206@pobox.com> <40905997.9020107@tomt.net> <409073B1.1020901@pobox.com>
In-Reply-To: <409073B1.1020901@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>> Quick questions:
>>
>> Is the Intel 6300ESB ("Hence Rapids") AHCI based? So far this looks 
>> like ICH6 too me, but I may be mistaken.
> 
> The only Hance Rapids stuff I've seen was ICH5-R, but maybe it's carried 
> forward to the ICH6-R as well.
> 
> I don't know, I mainly know the underlying chipsets not the boards they 
> wind up being shipped on...

Ahh, ok. I'll try to dig a bit deeper, but finding such details on 
vendor websites is not always easy. Anyway, the board I'm looking at has 
a 64bit 66Mhz PCI-X bus & slot (it's a low-end server/workstation board, 
Intel E7210 Canterwood ES/MCH+6300ESB+FWH chipset), so the controller 
can easily be replaced with something else without losing out to much on 
the performance side of things. Like the Marvell, wich is on the PCI-X 
bus, onboard.

>> What about the Marvell 88SX5040 PCI-X SATA Controller?
> 
> Coming RSN.  That's my next priority, but I'm not as thrilled because 
> Marvell isn't an open design like AHCI.  I'm much more happy to promote 
> AHCI's sane, open design.

Sounds like a plan :-)
