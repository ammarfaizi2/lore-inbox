Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbTI2JqF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 05:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTI2JqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 05:46:05 -0400
Received: from catv-50624ad9.szolcatv.broadband.hu ([80.98.74.217]:40067 "EHLO
	catv-50624ad9.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S262958AbTI2JqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 05:46:01 -0400
Message-ID: <3F77FF51.1010104@freemail.hu>
Date: Mon, 29 Sep 2003 11:45:53 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.2.1) Gecko/20030225
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: mingo@elte.hu
Subject: Re: [patch] exec-shield-2.6.0-test6-G3
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 29 Sep 2003, Boszormenyi Zoltan wrote:
> 
>> this is a version against -test6-mm1.
>> Three differences from -test6-G3:
>> - Makefile EXTRAVERSION
>> - include/asm-i386/mmu.h trivial reject fix
>> - fs/proc/array.c, {task|current}->[e]uid replaced
>>    with tsk_[e]uid({task|current}) to compile.
>> 
>> The system is RH9, all errata fixes applied.
>> X does not start up. After
>> echo "0|1" >/proc/sys/kernel/exec-shield
>> it starts.
> 
> hm, X needed at least one fix along the way. (it assumed malloc()  
> executability on x86.) XFree86-4.3.0-33 works fine on my box, which
> version are you using?
> 
> 	Ingo

XFree86-4.3.0-2. Hm, should I start using packages
from rawhide or severn beta2 besides the unified
modutils+module-init-tools?

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

