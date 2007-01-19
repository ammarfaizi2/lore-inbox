Return-Path: <linux-kernel-owner+w=401wt.eu-S1750996AbXASQqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbXASQqO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 11:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbXASQqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 11:46:13 -0500
Received: from main.gmane.org ([80.91.229.2]:44044 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbXASQqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 11:46:12 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: Re: EDAC chipkill messages
Date: Fri, 19 Jan 2007 09:45:43 -0700
Message-ID: <45B0F5B7.4080703@cora.nwra.com>
References: <fa.CZkzgccjpiJW6cRrbtRvg/+4HMg@ifi.uio.no> <45B00CD7.8050802@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inferno.cora.nwra.com
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <45B00CD7.8050802@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Orion Poplawski wrote:
>> Can someone please explain to me what these mean?
>>
>> EDAC k8 MC1: general bus error: participating processor(local node 
>> origin), time-out(no timeout) memory transaction type(generic read), 
>> mem or i/o(mem access), cache level(generic)
>> EDAC MC1: CE page 0xfbf6f, offset 0x4d0, grain 8, syndrome 0xc8f4, row 
>> 1, channel 0, label "": k8_edac
>> EDAC MC1: CE - no information available: k8_edac Error Overflow set
>> EDAC k8 MC1: extended error code: ECC chipkill x4 error
>>
>> Thanks!
>>
> 
> Sounds like you're having some memory ECC errors.. some Memtest86, etc. 
> runs may be in order. You may be able to figure out from this info what 
> DIMM is having the problem.
> 

That was my assumption as well, but was hoping someone could decode the 
above information and point me to the problem chip.  I ran Memtest86 
overnight but found no problems, but don't know if it needs to run in a 
particular ECC mode.

This is a dual proc 275 system with 4 1GB DIMMs.  Guessing that MC1 is 
the controller on the second CPU.  Would row 1 be the second DIMM?

