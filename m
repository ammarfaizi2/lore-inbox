Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbTEGSf5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbTEGSf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:35:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17908 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262867AbTEGSfz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:35:55 -0400
Message-ID: <3EB954DF.7060701@mvista.com>
Date: Wed, 07 May 2003 11:47:59 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: Eric Piel <Eric.Piel@Bull.Net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: DELAYTIMER_MAX is defined
References: <3EB7E3DA.C50258A9@Bull.Net> <3EB81719.3050705@mvista.com> <3EB8B5EA.BD5D1C19@Bull.Net> <3EB8BA67.4060708@redhat.com> <3EB8F54C.CC5488F0@Bull.Net> <3EB92023.2000906@mvista.com> <3EB94E8F.2080001@redhat.com>
In-Reply-To: <3EB94E8F.2080001@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> george anzinger wrote:
> 
> 
>>This, of course, also says that we should not only limit the value of
>>overrun, but also do something different when it happens.
> 
> 
> That's legitimate and in this case we perhaps should publish this lower
> value since it can be limiting.  Since real work is involved in having
> higher values this constitutes another possible DoS in the code and has
> to be resolved.

As soon as I get a few other fires under control, I will be working on 
this and the limit on number of timers issue.  Andrew Morton suggested 
an rlimit for that.  Perhaps that is what should be used here also.

Seem reasonable?

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

