Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270257AbUJUGcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270257AbUJUGcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268995AbUJUG2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 02:28:44 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:21401 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270621AbUJUGYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 02:24:43 -0400
Message-ID: <41775625.6050102@yahoo.com.au>
Date: Thu, 21 Oct 2004 16:24:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Tim Cambrant <cambrant@acc.umu.se>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: power/disk.c: small fixups
References: <20041020181617.GA29435@elf.ucw.cz> <20041020193741.GA27096@shaka.acc.umu.se> <cone.1098338726.500663.12209.502@pc.kolivas.org>
In-Reply-To: <cone.1098338726.500663.12209.502@pc.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Tim Cambrant writes:
> 
>> On Wed, Oct 20, 2004 at 08:16:17PM +0200, Pavel Machek wrote:
>>
>>> power_down may never ever fail, so it does not really need to return
>>> anything. Kill obsolete code and fixup old comments. Please apply,
>>>
>>
>> ...
>>
>>> @@ -162,7 +163,7 @@
>>>   *
>>>   *    If we're going through the firmware, then get it over with 
>>> quickly.
>>>   *
>>> - *    If not, then call pmdis to do it's thing, then figure out how
>>> + *    If not, then call swsusp to do it's thing, then figure out how
>>>   *    to power down the system.
>>>   */
>>
>>
>> I hate to be picky, but changing "it's" to the more correct "its" would
>> perhaps be nice to do when you're at it?
> 
> 
> "it's" means it belongs to, so therefore "it's" is correct usage here.
> 

Actually this is an exception. "it's" is an abbreviation for "it is",
"its" is possessive.
