Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWDBCEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWDBCEK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 21:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWDBCEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 21:04:10 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:54678 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932369AbWDBCEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 21:04:09 -0500
Message-ID: <442F3116.6070202@bigpond.net.au>
Date: Sun, 02 Apr 2006 12:04:06 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>,
       Paolo Ornati <ornati@fastwebnet.it>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
References: <4404CF98.7020804@bigpond.net.au> <440508C9.6030701@bigpond.net.au>
In-Reply-To: <440508C9.6030701@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 2 Apr 2006 02:04:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Peter Williams wrote:
>> This version updates staircase scheduler to version 14.1 (thanks Con) 
>> and includes the latest smpnice patches
>>
>> A patch for 2.6.16-rc5 is available at:
>>
>> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.3.1-for-2.6.16-rc5.patch?download> 
>>
> 
> and for 2.6.16-rc5-mm1 at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.3.1-for-2.6.16-rc5-mm1.patch?download> 
> 
> 
>>
>> Very Brief Documentation:
>>
>> You can select a default scheduler at kernel build time.  If you wish to
>> boot with a scheduler other than the default it can be selected at boot
>> time by adding:
>>
>> cpusched=<scheduler>
>>
>> to the boot command line where <scheduler> is one of: ingosched,
>> ingo_ll, nicksched, staircase, spa_no_frills, spa_ws, spa_svr, spa_ebs
>> or zaphod.  If you don't change the default when you build the kernel
>> the default scheduler will be ingosched (which is the normal scheduler).
>>
>> The scheduler in force on a running system can be determined by the
>> contents of:
>>
>> /proc/scheduler
>>
>> Control parameters for the scheduler can be read/set via files in:
>>
>> /sys/cpusched/<scheduler>/
>>
>> Peter
> 
> 

Now available for 2.6.16 at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.3.1-for-2.6.16.patch?download>

and 2.6.16-mm2 at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.3.1-for-2.6.16-mm2.patch?download>

Con and Nick,
	I've taken the liberty of modifying staircase and nicksched (in the 
2.6.16-mm2 version) to support priority inheritance.  I'd appreciate it 
if you could review the code?

Thanks,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
