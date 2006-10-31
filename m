Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423794AbWJaS5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423794AbWJaS5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423799AbWJaS5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:57:13 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:5880 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423794AbWJaS5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:57:13 -0500
Message-ID: <45479B87.8000206@oracle.com>
Date: Tue, 31 Oct 2006 10:52:55 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Derek Fults <dfults@sgi.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow a hyphenated range in get_options
References: <1162315517.9542.372.camel@lnx-dfults.americas.sgi.com>	 <20061031101134.27d8238d.randy.dunlap@oracle.com> <1162320874.9524.402.camel@lnx-dfults.americas.sgi.com>
In-Reply-To: <1162320874.9524.402.camel@lnx-dfults.americas.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Fults wrote:
> Hi Randy,
> 
> On Tue, 2006-10-31 at 10:11 -0800, Randy Dunlap wrote:
>> On Tue, 31 Oct 2006 11:25:16 -0600 Derek Fults wrote:
>>
>>> This allows a hyphenated range of positive numbers in the string passed
>>> to command line helper function, get_options.    
>>>
>>> Signed-off-by: Derek Fults <dfults@sgi.com>  
>> Hi,
>> Needs justification (why?) and a user.
>>
> 
> Currently the command line option "isolcpus=" takes as its argument a
> list of cpus.  
> Format: <cpu number>,...,<cpu number>
> This can get extremely long when isolating the majority of cpus on a
> large system.  Valid values of  <cpu_number>  include all cpus, 0 to
> "number of CPUs in system - 1".

Yep, makes sense.  Just need to say so in the patch description
and supply a user of the code.

Thanks,
-- 
~Randy
