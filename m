Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266058AbUAQPi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 10:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266059AbUAQPhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 10:37:48 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:15799 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266058AbUAQPgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 10:36:40 -0500
Message-ID: <400954E1.2050807@cyberone.com.au>
Date: Sun, 18 Jan 2004 02:29:37 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Valdis.Kletnieks@vt.edu, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sched-idle and disk-priorities for 2.6.X
References: Your message of "Fri, 16 Jan 2004 19:10:47 +0100."             <20040116181047.GA1896@elf.ucw.cz> <200401161937.i0GJbJmv003365@turing-police.cc.vt.edu> <400953B9.3090900@tmr.com>
In-Reply-To: <400953B9.3090900@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bill Davidsen wrote:

> Valdis.Kletnieks@vt.edu wrote:
>
>> A better bet would be a patch that allowed you to set the maximum RSS 
>> size for
>> the process so it can basically thrash itself while leaving enough 
>> memory for
>> everybody else (and yes, I *know* how this can be self-defeating if the
>> thrashing app then increases the total I/O consumed to be higher than 
>> the I/O
>> bandwidth available - the point is that it's probably the high RSS 
>> value for
>> his application causing OTHER things to thrash that's the root cause 
>> of his
>> performance problem).
>
>
> Or you could use "ulimit -m" to set the RSS, of course.


I don't think that would do anything with 2.6 :P


