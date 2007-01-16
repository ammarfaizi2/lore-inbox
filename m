Return-Path: <linux-kernel-owner+w=401wt.eu-S1751851AbXAPQ5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbXAPQ5R (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbXAPQtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:49:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:6865 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbXAPQtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:49:09 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,197,1167638400"; 
   d="scan'208"; a="188673185:sNHT2220573824"
Message-ID: <45AD01FB.3050304@intel.com>
Date: Tue, 16 Jan 2007 08:48:59 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
MIME-Version: 1.0
To: Allen Parker <parker@isohunt.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: intel 82571EB gigabit fails to see link on 2.6.20-rc5 in-tree
 e1000 driver (regression)
References: <45AC7CB2.1010202@isohunt.com> <45ACFA96.4040902@isohunt.com>
In-Reply-To: <45ACFA96.4040902@isohunt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jan 2007 16:48:59.0881 (UTC) FILETIME=[3876FD90:01C7398E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allen Parker wrote:
> Allen Parker wrote:
>> I have a PCI-E pro/1000 MT Quad Port adapter, which works quite well 
>> under 2.6.19.2 but fails to see link under 2.6.20-rc5. Earlier today I 
>> reported this to e1000-devel@lists.sf.net, but thought I should get 
>> the word out in case someone else is testing this kernel on this nic 
>> chipset.
>>
>> Due to changes between 2.6.19.2 and 2.6.20, Intel driver 7.3.20 will 
>> not compile for 2.6.20, nor will the 2.6.19.2 in-tree driver.
>>
> <snip, worthless>
> Affected chipset:
>> lspci -nn output (quad port):
>> 09:00.0 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit 
>> Ethernet Controller [8086:10a4] (rev 06)
>> lspci -nn output (dual port):
>> 07:00.0 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit 
>> Ethernet Controller [8086:105e] (rev 06)
> <snip, readability>
> 
>>  From what I've been able to gather, other Intel Pro/1000 chipsets 
>> work fine in 2.6.20-rc5. If the e1000 guys need any assistance 
>> testing, I'll be more than happy to volunteer myself as a guinea pig 
>> for patches.
> 
> I wasn't aware that I was supposed to post this as a regression, so 
> changed the subject, hoping that someone will pick this up and run with 
> it. Primary issue being that link is not seen on this chipset under 
> 2.6.20-rc5 via in-tree e1000 driver, despite multiple cycles of ifconfig 
> $eth up && ethtool $eth | grep link && ifconfig $eth down. Tested on 2 
> machines with identical hardware.

I asked Allen to report this here. I'm working on the issue as we speak but for now I'll 
treat the link issue as a known regression once I confirm it. If others have seen it 
then I'd like to know ASAP of course ;)

Cheers,

Auke
