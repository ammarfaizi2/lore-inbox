Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266020AbSIRK4C>; Wed, 18 Sep 2002 06:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266023AbSIRK4C>; Wed, 18 Sep 2002 06:56:02 -0400
Received: from smtpout.mac.com ([204.179.120.87]:24532 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S266020AbSIRK4C>;
	Wed, 18 Sep 2002 06:56:02 -0400
Date: Wed, 18 Sep 2002 13:00:58 +0200
Subject: Re: Oops in sched.c on PPro SMP
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
To: Andrea Arcangeli <andrea@suse.de>
From: Peter Waechtler <pwaechtler@mac.com>
In-Reply-To: <20020917174123.GU11605@dualathlon.random>
Message-Id: <E960A457-CAF5-11D6-8873-00039387C942@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag den, 17. September 2002, um 19:41, schrieb Andrea Arcangeli:

> On Tue, Sep 17, 2002 at 07:11:52PM +0200, Peter Waechtler wrote:
>> Once I had a machine check exception - sine then I lowered the CPU 
>> clock.
>> After the box was running fine with 180MHz I switched to 200MHz
>> (yes, I overclocked the CPUs with 233MHz 2 or 3 years - without 
>> problems)
>
> I guess this explain the corruption. Please make sure the cpu are not
> overclocked at all and then try to reproduce. You cannot choose 180mhz
> or 200mhz randomly based on which kernel crashes or not, if the cpu are
> 180mhz ppro you should use 180mhz only, 200mhz will break.  It won't
> break so easily as 233mhz, but it will, the timings are strict on smp.
> So please try to reproduce at 180mhz if the cpu should run at 180mhz.
>
> I don't want to sound boring but please next times try if you can
> reproduce on non overclocked hardware before reporting anything to l-k.
>

They are 200MHz PPros. So don't be bored.
To minimize the risk, I underclocked them, eh?

I slowed down memory timings - the box survived one night - but it
would be too early to count on this.

