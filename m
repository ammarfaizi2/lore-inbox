Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbVIINpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVIINpu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 09:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVIINpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 09:45:50 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:1975 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932561AbVIINpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 09:45:49 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Marko Kohtala <marko.kohtala@gmail.com>
Subject: Re: 2.6.13-mm2
Date: Fri, 09 Sep 2005 23:45:38 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <d243i19hk055rl5b5o5i9suofsvbmv5r8l@4ax.com>
References: <20050908053042.6e05882f.akpm@osdl.org> <m1q1i1lav2vl7k0lpposq0uj4uobsptnor@4ax.com> <20050909024336.01763521.akpm@osdl.org>
In-Reply-To: <20050909024336.01763521.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Marko,
On Fri, 9 Sep 2005 02:43:36 -0700, Andrew Morton <akpm@osdl.org> wrote:

>Grant Coady <grant_lkml@dodo.com.au> wrote:
>>
>> On Thu, 8 Sep 2005 05:30:42 -0700, Andrew Morton <akpm@osdl.org> wrote:
>> 
>> >
>> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
>> 
>> Hi Andrew,
>> 
>> After this error:
>> 
>>   CC      drivers/parport/parport_pc.o
>> drivers/parport/parport_pc.c:2511: error: via_686a_data causes a section type conflict
>> drivers/parport/parport_pc.c:2520: error: via_8231_data causes a section type conflict
>> drivers/parport/parport_pc.c:2705: error: parport_pc_superio_info causes a section type conflict
>> drivers/parport/parport_pc.c:2782: error: cards causes a section type conflict
>> make[2]: *** [drivers/parport/parport_pc.o] Error 1
>> make[1]: *** [drivers/parport] Error 2
>> make: *** [drivers] Error 2
>
>Yes, gcc 4.x doesn't like the consts for some reason.

Not using gcc 4.x, Slackware-10.1+ with Gnu C 3.3.6
>
>diff -puN drivers/parport/parport_pc.c~a drivers/parport/parport_pc.c
[...]
Thank you, compile completed :o)  Bonus!  It booted too.

Grant.

