Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWJ2Aac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWJ2Aac (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 20:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWJ2Aac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 20:30:32 -0400
Received: from mail.tmr.com ([64.65.253.246]:17315 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1751445AbWJ2Aab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 20:30:31 -0400
Message-ID: <4543F621.4000908@tmr.com>
Date: Sat, 28 Oct 2006 20:30:25 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Frustrated with Linux, Asus, and nVidia, and AMD
References: <453EEE46.9040600@perkel.com> <p73vem8kyuv.fsf@verdi.suse.de>
In-Reply-To: <p73vem8kyuv.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Marc Perkel <marc@perkel.com> writes:
> 
>> Ok - I had a bad day today struggling with hardware. Having said that
>> I'm somewhat frustrated with the lack of progress of Linux getting it
>> right with Asus, nVidia, and AMD processors right.
>>
>> I still have to run pci=nommconf to keep the server from locking
>> up. That's with both 939 pin and AM2 motherboards.
>>
>> This bug remains unresolved:
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=6975
>>
>> So what's up with the no progress?
> 
> The bug report only references ancient kernels (2.6.15, 2.6.17) How do you know there is no
> progress?

2.6.18 is the latest released kernel, I don't think calling one release 
back "ancient" is really advancing the solution. The problem seems to 
have been reported in August, and is still not fixed, I do understand 
that he would feel there is no progress.

How long will you wait before putting in the fix Marc Perkel suggested, 
perhaps with a warning logged that it's a band-aid? Many users will not 
be astute enough to find this discussion, the bug report, the fix, 
configure and build a kernel, etc. And not all distributions will 
address it either.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
