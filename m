Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269861AbTGKJna (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 05:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269862AbTGKJna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 05:43:30 -0400
Received: from dyn-ctb-203-221-72-236.webone.com.au ([203.221.72.236]:15372
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S269861AbTGKJn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 05:43:28 -0400
Message-ID: <3F0E8A22.6020700@cyberone.com.au>
Date: Fri, 11 Jul 2003 19:57:54 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 898] New: Very HIGH File & VM system latencies and system
 stop responding while extracting big tar  archive file.
References: <111930000.1057904059@[10.10.2.4]> <200307111346.39731.rathamahata@php4.ru>
In-Reply-To: <200307111346.39731.rathamahata@php4.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sergey S. Kostyliov wrote:

>Hello all,
>
>On Friday 11 July 2003 10:14, Martin J. Bligh wrote:
>
>>http://bugme.osdl.org/show_bug.cgi?id=898
>>
>>           Summary: Very HIGH File & VM system latencies and system stop
>>                    responding while extracting big tar  archive file.
>>    Kernel Version: 2.5.75
>>            Status: NEW
>>          Severity: high
>>             Owner: bugme-janitors@lists.osdl.org
>>         Submitter: bakhtiar@softhome.net
>>
>>
>>Distribution:Slackware v7.1 : glibc v2.1.3
>>Hardware Environment: P!!! 550 MHz, 256 MB RAM. HP Brio BA600
>>
>
>The same issues here with 2.5.7{4,5}. IO-intencive task got stuck in 'D'
>state (bk,rsync,tar - it really doesn't matter). I think a have to get decoded
>Alt-SysRq-T for this tasks next time. 
>

You're sure 2.5.74 got processes stuck in D? That means its possibly
a driver bug. If you can get 2.5.75 to hang, please also try with
elevator=deadline. Thank you.

Nick


