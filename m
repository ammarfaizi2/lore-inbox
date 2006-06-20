Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWFTUxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWFTUxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWFTUxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:53:34 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:15841 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751037AbWFTUxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:53:33 -0400
Message-ID: <44986043.8060609@garzik.org>
Date: Tue, 20 Jun 2006 16:53:23 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Brice Goglin <brice@myri.com>
CC: greg.lindahl@qlogic.com, "Randy.Dunlap" <rdunlap@xenotime.net>, ak@suse.de,
       olson@unixfolk.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check
 Hyper-transport capabilities
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no> <fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no> <Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com> <200606200925.30926.ak@suse.de> <20060620200352.GJ1414@greglaptop.internal.keyresearch.com> <20060620132049.ff5e6f67.rdunlap@xenotime.net> <20060620204109.GA1980@greglaptop.internal.keyresearch.com> <44985F9A.6000108@myri.com>
In-Reply-To: <44985F9A.6000108@myri.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin wrote:
> Greg Lindahl wrote:
>> Andi, is the tg3 NIC that didn't work in a Supermicro system
>> on PCI-X or PCI Express?
>>   
> 
> IIRC, Andi was talking about a Supermicro machine with a ServerWorks
> HT2000 chipset. We have such a machine here. Its MSI is disabled in the
> Hyper-transport mapping. But, MSI works once the HT capability is
> enabled (and my quirk will detect it right).
> For such machines, if people really want MSI, we'll need to enable the
> HT cap in my quirk. But, as long as they just want IRQ to work,
> detecting whether the HT cap is enabled or not should be enough.

If it works reliably, we should definitely turn it on.

	Jeff, wishing his HT1000 did the same



