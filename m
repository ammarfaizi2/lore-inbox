Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264120AbTLEOwN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 09:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264142AbTLEOwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 09:52:13 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:4819 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S264120AbTLEOwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 09:52:11 -0500
Message-ID: <3FD09B8E.7020701@softhome.net>
Date: Fri, 05 Dec 2003 15:51:58 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Smietanowski <stesmi@stesmi.com>
CC: Helge Hafting <helgehaf@aitel.hist.no>,
       Jason Kingsland <Jason_Kingsland@hotmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
References: <YPep.5Y5.21@gated-at.bofh.it> <Z3AK-Qw-13@gated-at.bofh.it> <3FCF696F.4000605@softhome.net> <3FD067CF.4010207@aitel.hist.no> <3FD07611.4050709@stesmi.com>
In-Reply-To: <3FD07611.4050709@stesmi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski wrote:
> Helge Hafting wrote:
> 
>> Ihar 'Philips' Filipau wrote:
>>
>>>   GPL is about distribution.
>>>
>>>   e.g. NVidia can distribute .o file (with whatever license they have 
>>> to) and nvidia.{c,h} files (even under GPL license).
>>>   Then install.sh may do on behalf of user "gcc nvidia.c blob.o -o 
>>> nvidia.ko". Resulting module are not going to be distributed - it is 
>>> already at hand of end-user. So no violation of GPL whatsoever.
>>
>>
>>
>> Open source still win if they do this.  Anybody interested
>> may then read the restricted source and find out how
>> the chip works.  They may then write an open driver
>> from scratch, using the knowledge.
> 
> 
> What I think he means is that nvidia.c only contains glue code and
> blob.o contains the secret parts just like the current driver from
> nvidia.
> 

   Exactly.
   Source code licensing from second parties is really pain in the ass.

   At my previous job I had situation that piece of code was several 
times. I beleive we were fourth company who bought it and incorporated 
into applience. But ask anyone "what kind of rights do we have for this 
stuff?" - no-one really can answer, since we-are-not-lawyers so better 
to tell no-one how we use it. Probably we even had no rights to fix 
bugs... who knows?..

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

