Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTLDRG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 12:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTLDRG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 12:06:28 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:31213 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S263185AbTLDRGZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 12:06:25 -0500
Message-ID: <3FCF696F.4000605@softhome.net>
Date: Thu, 04 Dec 2003 18:05:51 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jason Kingsland <Jason_Kingsland@hotmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
References: <YPep.5Y5.21@gated-at.bofh.it> <Z3AK-Qw-13@gated-at.bofh.it>
In-Reply-To: <Z3AK-Qw-13@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Kingsland wrote:
> On Wed, 3 Dec 2003, "Linus Torvalds" wrote:
> 
> 
>>And in fact, when it comes to modules, the GPL issue is exactly the same.
>>The kernel _is_ GPL. No ifs, buts and maybe's about it. As a result,
>>anything that is a derived work has to be GPL'd. It's that simple.
>>...
>> - anything that has knowledge of and plays with fundamental internal
>>   Linux behaviour is clearly a derived work. If you need to muck around
>>   with core code, you're derived, no question about it.
> 
> 
> 
> If that is the case, why the introduction of EXPORT_SYMBOL_GPL and
> MODULE_LICENSE()?
> 
> Specifying explicit boundaries for the module interface has legitimised
> binary-only modules.
> This was the signal to developers of proprietary code that binary-only
> modules are tolerable.
> 
> Note that I said tolerable, not acceptable. Ref also the 'tainted' flag
> ("man 8 insmod")
> My personal view is that Linux should mandate GPL for all modules in 2.6 and
> beyond.
> 

   GPL is about distribution.

   e.g. NVidia can distribute .o file (with whatever license they have 
to) and nvidia.{c,h} files (even under GPL license).
   Then install.sh may do on behalf of user "gcc nvidia.c blob.o -o 
nvidia.ko". Resulting module are not going to be distributed - it is 
already at hand of end-user. So no violation of GPL whatsoever.

   Licensing is least technical issue regarding modules.
   But sure I would like to have open source drivers - at least then I 
have chance to clean them up ;-)))

   my 2 eurocents.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

