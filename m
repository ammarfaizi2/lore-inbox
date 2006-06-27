Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWF0SEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWF0SEB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWF0SEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:04:01 -0400
Received: from mga03.intel.com ([143.182.124.21]:42810 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932508AbWF0SEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:04:00 -0400
X-IronPort-AV: i="4.06,183,1149490800"; 
   d="scan'208"; a="58170236:sNHT4339733132"
Message-ID: <44A172E5.1030905@intel.com>
Date: Tue, 27 Jun 2006 11:03:17 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.4 (X11/20060617)
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: netdev@vger.kernel.org, john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: e1000: Janitor: Use #defined values for literals
References: <20060623163624.GM8866@austin.ibm.com> <449C49F9.6090005@intel.com> <20060627173224.GA31770@austin.ibm.com>
In-Reply-To: <20060627173224.GA31770@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jun 2006 18:03:17.0802 (UTC) FILETIME=[F7BC80A0:01C69A13]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> On Fri, Jun 23, 2006 at 01:07:21PM -0700, Auke Kok wrote:
>> Linas Vepstas wrote:
>>> Minor janitorial patch: use #defines for literal values.
>>> +	pci_enable_wake(pdev, PCI_D3hot, 0);
>>> +	pci_enable_wake(pdev, PCI_D3cold, 0);
>> I Acked this but that's silly - the patches sent yesterday already change 
>> the code above and this patch is no longer needed (thanks Jesse for 
>> spotting this).
>>
>> This patch would conflict with them so please don't apply.
> 
> Maybe there's a backlog in the queue, but I not this is not 
> yet in 2.6.17-mm3 

It's part of the submission for 2.6.18 I sent to jgarzik on friday, which 
cleans up this section in the way.

Auke
