Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268372AbUHLCyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268372AbUHLCyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 22:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268374AbUHLCyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 22:54:08 -0400
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:58781 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268372AbUHLCyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 22:54:04 -0400
References: <20040812022420.58366.qmail@web13909.mail.yahoo.com>
Message-ID: <cone.1092279237.748749.1407.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: spaminos-ker@yahoo.com
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and
         others)
Date: Thu, 12 Aug 2004 12:53:57 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spaminos-ker@yahoo.com writes:

> --- Con Kolivas <kernel@kolivas.org> wrote:
>> 
>> Hi
>> 
>> I tried this on the latest staircase patch (7.I) and am not getting any 
>> output from your script when tested up to 60 threads on my hardware. Can you 
>> try this version of staircase please?
>> 
>> There are 7.I patches against 2.6.8-rc4 and 2.6.8-rc4-mm1
>> 
>> http://ck.kolivas.org/patches/2.6/2.6.8/
>> 
>> Cheers,
>> Con
>> 
>> 
> 
> One thing to note is that I do get a lot of output from the script if I set
> interactive to 0 (delays between 3 and 13 seconds with 60 threads).

Sounds fair. 

With interactive==0 it will penalise tasks during their bursts of cpu usage 
in the interest of fairness, and your script effectively is BASH doing a 
burst of cpu so 3-13 second delays when the load is effectively >60 is 
pretty good.

Cheers,
Con

