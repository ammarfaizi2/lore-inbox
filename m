Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263995AbUFBTyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUFBTyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 15:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbUFBTyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 15:54:50 -0400
Received: from mail.tmr.com ([216.238.38.203]:28428 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263995AbUFBTyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 15:54:41 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: swappiness ignored
Date: Wed, 02 Jun 2004 15:54:55 -0400
Organization: TMR Associates, Inc
Message-ID: <c9lb2n$l17$1@gatekeeper.tmr.com>
References: <40B43B5F.8070208@nodivisions.com> <200405260940.i4Q9eJdS000767@81-2-122-30.bradfords.org.uk> <40BC2EFA.6090503@nodivisions.com> <200406011136.17055@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1086205847 21543 192.168.12.100 (2 Jun 2004 19:50:47 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <200406011136.17055@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:
> On Tuesday 01 June 2004 09:23, Anthony DiSante wrote:
> 
> Hi Anthony,
> 
> 
>>In the "why swap at all" thread, there was mention of the
>>/proc/sys/vm/swappiness tunable, and some people suggested echoing a zero
>>to there if you want to minimize/disable swap usage, or echoing a 100 to
>>maximize swap usage, etc.
>>But on my 2.6.5 system, I can echo a zero to there, then cat it back to
>>make sure... then 30 seconds later cat it again, and it's been changed to
>>something else (50, 60, 80something).
>>Is this supposed to be a value that can be manually adjusted, as some have
>>claimed, or is it something the kernel manages automatically?  I definitely
>>can't manually set it without having it overwritten shortly thereafter.
> 
> 
> I bet you have /proc/sys/vm/autoswappiness or the previous version of it 
> w/o /proc stuff.

What option do I need to enable so I can get this control (to disable 
it)? I have sysctl enabled in 2.6.7-rc1 and no autoswappiness to be found.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
