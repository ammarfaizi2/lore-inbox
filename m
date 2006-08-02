Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWHBPIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWHBPIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWHBPIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:08:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:52900 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751091AbWHBPIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:08:00 -0400
X-IronPort-AV: i="4.07,205,1151910000"; 
   d="scan'208"; a="100802076:sNHT2918481097"
Message-ID: <44D0BF60.4050905@intel.com>
Date: Wed, 02 Aug 2006 08:06:08 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Shawn Starr <shawn.starr@rogers.com>
CC: linux-kernel@vger.kernel.org, NetDev <netdev@vger.kernel.org>
Subject: Re: [2.6.18-rc2][e1000][swsusp] - Regression - Suspend to disk and
 resume breaks e1000 - RESOLVED Bug #6867
References: <200607160509.52930.shawn.starr@rogers.com> <44BA6A4A.5090007@intel.com> <200608012355.28504.shawn.starr@rogers.com>
In-Reply-To: <200608012355.28504.shawn.starr@rogers.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Aug 2006 15:07:25.0711 (UTC) FILETIME=[5D1231F0:01C6B645]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> On Sunday 16 July 2006 12:33 pm, Auke Kok wrote:
>> [adding netdev to the cc]
>>
>> unfortunately I didn't.
>>
>> e1000 has a special e1000_pci_save_state/e1000_pci_restore_state set of
>> routines that save and restore the configuration space. the fact that it
>> works for suspend to memory to me suggests that there is nothing wrong with
>> that.

> Hi Auke,
> 
> It appears 2.6.18-rc3 this does not occur anymore. I suspended to disk/ram and 
> the interface pci registers were restored. Bugzilla #6867

I would not be surprised if all the suspend issues in 2.6.18rcX were not 
involved in this somehow... thanks for reporting back in.

Auke
