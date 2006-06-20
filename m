Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWFTU0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWFTU0s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWFTU0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:26:47 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:23775 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750933AbWFTU0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:26:46 -0400
Message-ID: <449859EF.7090507@myri.com>
Date: Tue, 20 Jun 2006 16:26:23 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Greg Lindahl <greg.lindahl@qlogic.com>, ak@suse.de, olson@unixfolk.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check
 Hyper-transport capabilities
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no>	<fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no>	<Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com>	<200606200925.30926.ak@suse.de>	<20060620200352.GJ1414@greglaptop.internal.keyresearch.com> <20060620132049.ff5e6f67.rdunlap@xenotime.net>
In-Reply-To: <20060620132049.ff5e6f67.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Tue, 20 Jun 2006 13:03:52 -0700 Greg Lindahl wrote:
>   
>> You probably meant the other Greg, but the situation doesn't seem to
>> be that bad. Brice's proposed whitelist covers almost all Opteron PCI
>> Express servers.
>>     
>
> Why "almost"?  What does a user do if his/hers is not covered?
> Does it cover the 10 new models that are available tomorrow?
> (hypothetical question)
>   

At least, it will not be worse than currently for new PCI-E chipsets (my
patch still enables MSI by default for these).

But, my quirks to check the MSI cap in the HT mapping might need to be
enabled for more chipsets (I only handle nVidia Ck804 and ServerWorks
HT2000).

Brice

