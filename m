Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270846AbUJUTeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270846AbUJUTeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 15:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270833AbUJUTaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:30:11 -0400
Received: from mail.tmr.com ([216.238.38.203]:54540 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S270845AbUJUT3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:29:36 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: power/disk.c: small fixups
Date: Thu, 21 Oct 2004 15:31:53 -0400
Organization: TMR Associates, Inc
Message-ID: <cl927p$aja$1@gatekeeper.tmr.com>
References: <20041020193741.GA27096@shaka.acc.umu.se> <cone.1098338726.500663.12209.502@pc.kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1098386490 10858 192.168.12.100 (21 Oct 2004 19:21:30 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <cone.1098338726.500663.12209.502@pc.kolivas.org>
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

In this case, no. "its" is posessive already, without the apostrophe.

See: http://owl.english.purdue.edu/handouts/grammar/g_apost.html

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
