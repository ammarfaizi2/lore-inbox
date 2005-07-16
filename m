Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVGPTBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVGPTBr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 15:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVGPTBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 15:01:47 -0400
Received: from mxsf18.cluster1.charter.net ([209.225.28.218]:55257 "EHLO
	mxsf18.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261393AbVGPTBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 15:01:42 -0400
X-IronPort-AV: i="3.93,295,1115006400"; 
   d="scan'208"; a="1140775748:sNHT33618058"
Message-ID: <42D95992.9090901@cybsft.com>
Date: Sat, 16 Jul 2005 14:01:38 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Karsten Wiese <annabellesgarden@yahoo.de>,
       Chuck Harding <charding@llnl.gov>, William Weston <weston@sysex.net>,
       Linux Kernel Discussion List <linux-kernel@vger.kernel.org>,
       Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050713103930.GA16776@elte.hu> <42D51EAF.2070603@cybsft.com> <200507141450.42837.annabellesgarden@yahoo.de> <20050716171537.GB16235@elte.hu>
In-Reply-To: <20050716171537.GB16235@elte.hu>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> 
> 
>>Have I corrected the other path of ioapic early initialization, which 
>>had lacked virtual-address setup before ioapic_data[ioapic] was to be 
>>filled in -51-28? Please test attached patch on top of -51-29 or 
>>later. Also on Systems that liked -51-28.
> 
> 
> thanks - i've applied it to my tree and have released the -51-31 patch.  
> It looks good on my testboxes.
> 
> 	Ingo
> 

I have booted this on my older SMP system (the one that wouldn't boot
-51-28) as well as an older duron box and thus far all is well.

-- 
   kr
