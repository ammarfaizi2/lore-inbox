Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTJaR4Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 12:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTJaR4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 12:56:16 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:14541 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S263463AbTJaR4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 12:56:14 -0500
Message-ID: <3FA2A240.2060105@metaparadigm.com>
Date: Sat, 01 Nov 2003 01:56:16 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Soboroff <ian.soboroff@nist.gov>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Post-halloween doc updates.
References: <20031030141519.GA10700@redhat.com>	<9cfd6cdla4o.fsf@rogue.ncsl.nist.gov>	<20031031152453.F4556@flint.arm.linux.org.uk> <9cfn0bhjswn.fsf@rogue.ncsl.nist.gov>
In-Reply-To: <9cfn0bhjswn.fsf@rogue.ncsl.nist.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/03 00:03, Ian Soboroff wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> writes:
> 
> 
>>On Fri, Oct 31, 2003 at 10:06:31AM -0500, Ian Soboroff wrote:
>>
>>>And APM suspend seems to have broken in -test8.  Does it work for
>>>anyone?
>>
>>Doesn't work for me.

APM working here nicely with -test9 on Thinkpad A31. Stilling getting
1394 badness when suspending/resuming with my cardbus 1394 controller
plugged in. Other than that, works pretty seamlessy with no cardbus
cards plugged.

Even radeon with VESA suspend/resume, DRI and X 4.3 (using some
precarious vtswitch calls in /etc/apm/event.d/). wlan-ng works okay
although it requires rmmod/modprobe to wake up properly after resume.

>>Now, taking off my "open source co-operative hat" and placing my
>>"reality" hat on, I'd suggest that anyone who finds that APM doesn't
>>work to consider it a dead loss - It's an obsolete technology, and
>>therefore no one is interested in it anymore.  I've reported the
>>problem multiple times here and there's been very little, if any,
>>reaction, so this seems to back that up.

Hmmm, well for me; a working APM (here) is much prefered to non-
working ACPI suspend/resume. I'd prefer not to obsolete APM until
there is a working alternative (with mature userspace tools).

~mc

