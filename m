Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbUASFkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 00:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbUASFkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 00:40:35 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:53202 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264364AbUASFkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 00:40:33 -0500
Message-ID: <400B6DAF.7090802@cyberone.com.au>
Date: Mon, 19 Jan 2004 16:39:59 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Valdis.Kletnieks@vt.edu, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sched-idle and disk-priorities for 2.6.X
References: Your message of "Fri, 16 Jan 2004 19:10:47 +0100."             <20040116181047.GA1896@elf.ucw.cz> <200401161937.i0GJbJmv003365@turing-police.cc.vt.edu> <400953B9.3090900@tmr.com> <400954E1.2050807@cyberone.com.au> <400B621D.7050307@tmr.com>
In-Reply-To: <400B621D.7050307@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bill Davidsen wrote:

> Nick Piggin wrote:
>
>>
>>
>> Bill Davidsen wrote:
>>
>>>
>>> Or you could use "ulimit -m" to set the RSS, of course.
>>
>>
>>
>>
>> I don't think that would do anything with 2.6 :P
>
>
> Does that imply that the feature doesn't function as documented in 
> 2.6? Or is that a SysV-ism not in SuS and documented but not 
> implemented, or what other reason would there be for it to not work?
>

The first one. AFAIKS ulimit RSS doesn't do anything in the 2.6 vm.

Rik has a fairly straightforward looking implementation in his 2.4 vm
which probably wouldn't be too hard to forward port. It doesn't impose
a hard limit on RSS though: I'm not sure what the standards say about that.


