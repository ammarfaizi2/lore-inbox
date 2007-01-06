Return-Path: <linux-kernel-owner+w=401wt.eu-S932199AbXAFUw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbXAFUw3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbXAFUw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:52:29 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:45303 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206AbXAFUw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:52:28 -0500
Message-ID: <45A00C0B.90901@vmware.com>
Date: Sat, 06 Jan 2007 12:52:27 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org, ak@suse.de,
       chrisw@sous-sol.org, jeremy@xensource.com, rusty@rustcorp.com.au
Subject: Re: + paravirt-vmi-timer-patches.patch added to -mm tree
References: <200612152227.kBFMRNuQ002977@shell0.pdx.osdl.net> <1168102492.26086.215.camel@imap.mvista.com>
In-Reply-To: <1168102492.26086.215.camel@imap.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Fri, 2006-12-15 at 14:27 -0800, akpm@osdl.org wrote:
>   
>> +
>> +unsigned long long vmi_sched_clock(void)
>> +{
>> +       return read_available_cycles();
>> +}
>> + 
>>     
>
>
> This sched_clock is likely broken if it's returning something other than
> nanoseconds. It looks like cycles, but it's also getting piped through
> an ops pointer so I'm not sure what's getting returned here.
>   

Thanks, I'll fix that.

Zach
