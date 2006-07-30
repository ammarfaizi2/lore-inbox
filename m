Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWG3RsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWG3RsI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWG3RsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:48:07 -0400
Received: from mga05.intel.com ([192.55.52.89]:3881 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932392AbWG3RsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:48:06 -0400
X-IronPort-AV: i="4.07,196,1151910000"; 
   d="scan'208"; a="107427638:sNHT14334747"
Message-ID: <44CCF0BF.5050309@linux.intel.com>
Date: Sun, 30 Jul 2006 19:47:43 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector feature
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <200607292050.37877.ak@suse.de> <20060729185737.GG26963@stusta.de> <200607292104.18030.ak@suse.de>            <20060729191938.GH26963@stusta.de> <200607301614.k6UGEpIL023020@turing-police.cc.vt.edu>
In-Reply-To: <200607301614.k6UGEpIL023020@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Sat, 29 Jul 2006 21:19:38 +0200, Adrian Bunk said:
> 
>> That was never true in Arjan's patches.
>>
>> The only change is from a gcc version check to a feature check.
>>
>> In both cases, a gcc 4.1 without the appropriate patch applied will 
>> result in this option not being set.
> 
> What do you get if you have a gcc 4.1.1. that has the stack protector option
> (so a feature check works), but not the fix for gcc PR 28281?

the feature check actually checks for a correctly operating gcc, not just for the "option exists"
