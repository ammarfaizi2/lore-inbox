Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWCaF1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWCaF1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 00:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWCaF1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 00:27:45 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:14055 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750752AbWCaF1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 00:27:44 -0500
Message-ID: <442CBDC8.50401@watson.ibm.com>
Date: Fri, 31 Mar 2006 00:27:36 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peterc@gelato.unsw.edu.au>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, greg@kroah.com,
       arjan@infradead.org, hadi@cyberus.ca, ak@suse.de,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Patch 0/8] per-task delay accounting
References: <442B271D.10208@watson.ibm.com>	<20060329210314.3db53aaa.akpm@osdl.org>	<20060330062357.GB18387@in.ibm.com>	<20060329224737.071b9567.akpm@osdl.org>	<442C140C.8040404@watson.ibm.com> <17452.39418.693521.149502@wombat.chubb.wattle.id.au>
In-Reply-To: <17452.39418.693521.149502@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:

>>>>>>"Shailabh" == Shailabh Nagar <nagar@watson.ibm.com> writes:
>>>>>>            
>>>>>>
>
>  
>
>Shailabh> To this list we can also add
>
>Shailabh>     Microstate accounting Peter Chubb
>Shailabh> <peter@chubb.wattle.id.au> I don't know if Peter is still
>Shailabh> interested in pursuing this or it was rejected.
>
>It's still maintained in a sporadic sort of way --- I update it when
>either I need it for something, or someone's downloaded it and asks
>why it doesn't work agains kernel X.Y.Z.  I see a few downloads a
>month.
>  
>
So do you intend to pursue acceptance ? If so, do you think the 
netlink-based taskstats
interface provided by the delay accounting patches could be an 
acceptable substitute for the
interfaces you had (from  an old lkml post, they appear  to be  
/proc/tgid/msa and  a syscall
based one) ?
 

>My microstate accounting patch overlaps the delay accounting patch quite a
>lot in functionality, (but I thnk mine is cleaner except for interrupt
>time accounting... which the delay accounting patch doesn't do.  I
>wanted to know how much time a thread *really* had on the processor,
>subtracting off the time spent in interrupt handlers for some other
>process).
>  
>
Thanks. Will incorporate into a note on the mechanisms of the other 
accounting patches.

--Shailabh


