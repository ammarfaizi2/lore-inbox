Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267899AbUHKDKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267899AbUHKDKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 23:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267905AbUHKDKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 23:10:12 -0400
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:46309 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267899AbUHKDKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 23:10:03 -0400
References: <20040811022143.4892.qmail@web13910.mail.yahoo.com>
Message-ID: <cone.1092193795.772385.25569.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: spaminos-ker@yahoo.com
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and
         others)
Date: Wed, 11 Aug 2004 13:09:55 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spaminos-ker@yahoo.com writes:

> --- William Lee Irwin III <wli@holomorphy.com> wrote:
>> 
>> Wakeup bonuses etc. are starving tasks. Could you try Peter Williams'
>> SPA patches with the do_promotions() function? I suspect these should
>> pass your tests.
>> 
>> 
>> -- wli
>> 
> 
> I tried the patch-2.6.7-spa_hydra_FULL-v4.0 patch
> 
> I only changed the value of /proc/sys/kernel/cpusched/mode to switch between
> different patches.
> 
> The 2 threads test passes successfuly (improvement over stock 2.6.7) but none
> passed the 20 threads test:

Hi

I tried this on the latest staircase patch (7.I) and am not getting any 
output from your script when tested up to 60 threads on my hardware. Can you 
try this version of staircase please?

There are 7.I patches against 2.6.8-rc4 and 2.6.8-rc4-mm1

http://ck.kolivas.org/patches/2.6/2.6.8/

Cheers,
Con

