Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWHKVR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWHKVR6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWHKVR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:17:58 -0400
Received: from rtr.ca ([64.26.128.89]:31442 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932303AbWHKVR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:17:57 -0400
Message-ID: <44DCF402.4090509@rtr.ca>
Date: Fri, 11 Aug 2006 17:17:54 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
Cc: Dave Jones <davej@redhat.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
References: <EB12A50964762B4D8111D55B764A84546F8EC3@scsmsx413.amr.corp.intel.com> <44DCE8BA.2070601@rtr.ca> <44DCEAF7.5020005@rtr.ca> <20060811210104.GL26930@redhat.com> <44DCF360.7050305@rtr.ca>
In-Reply-To: <44DCF360.7050305@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Mmm.. spoke too soon.
> 
> I have not actually rebooted since killing powernowd,
> and it just happened again now.  No powernowd running.
> 
> Limit dropped from 1100Mhz to 800Mhz (log below).

Again.. with the log..


[ 3608.828000] cpufreq-core: updating policy for CPU 0
[ 3608.828000] cpufreq-core: Warning: CPU frequency out of sync: cpufreq and timing core thinks of 1100000, is 800000 kHz.
[ 3608.828000] cpufreq-core: notification 0 of frequency transition to 800000 kHz
[ 3608.828000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[ 3608.828000] cpufreq-core: notification 1 of frequency transition to 800000 kHz
[ 3608.828000] cpufreq-core: scaling loops_per_jiffy to 3195840 for frequency 800000 kHz
[ 3608.828000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[ 3608.828000] cpufreq-core: setting new policy for CPU 0: 600000 - 1100000 kHz
[ 3608.828000] freq-table: request for verification of policy (600000 - 1100000 kHz) for cpu 0
[ 3608.828000] freq-table: verification lead to (600000 - 1100000 kHz) for cpu 0
[ 3608.828000] freq-table: request for verification of policy (600000 - 800000 kHz) for cpu 0
[ 3608.828000] freq-table: verification lead to (600000 - 800000 kHz) for cpu 0
[ 3608.828000] cpufreq-core: new min and max freqs are 600000 - 800000 kHz
[ 3608.828000] cpufreq-core: governor: change or update limits
[ 3608.828000] cpufreq-core: __cpufreq_governor for CPU 0, event 3
