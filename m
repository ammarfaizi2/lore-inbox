Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265629AbRFWEyN>; Sat, 23 Jun 2001 00:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265626AbRFWEyE>; Sat, 23 Jun 2001 00:54:04 -0400
Received: from apollo.cis.from.de ([194.162.209.12]:9346 "EHLO
	apollo.cis.from.de") by vger.kernel.org with ESMTP
	id <S265629AbRFWExv>; Sat, 23 Jun 2001 00:53:51 -0400
Mime-Version: 1.0
Message-Id: <p05100323b759d0c24582@[194.162.209.20]>
In-Reply-To: <014301c0fb94$217aee50$1a01a8c0@allyourbase>
In-Reply-To: <fa.h2turhv.121c3bs@ifi.uio.no>
 <014301c0fb94$217aee50$1a01a8c0@allyourbase>
Date: Sat, 23 Jun 2001 06:53:33 +0200
To: "Dan Maas" <dmaas@dcine.com>
From: Ingo Ciechowski <ciechowski@cis-computer.com>
Subject: Re: High system CPU% in dual CPU System
Cc: linux-kernel@vger.kernel.org, stimits@idcomm.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:25 Uhr -0400 22.06.2001, Dan Maas wrote:
>  > CPU0 states: 19.2% user, 32.0% system,  0.0% nice, 48.2% idle
>>  CPU1 states: 20.4% user, 40.1% system,  0.0% nice, 38.3% idle
>
>>  What can I do to find out what the CPUs are doing during "system" time?
>
>Try 'ps -ax' and see if any process has a large TIME (cumulative CPU time).
>I suspect you may just be seeing a kernel idle process (e.g. kapm-idled),
>which is nothing to worry about.


Hi Dan,

thanx for the hint. I could identify one of my scripts as cause of 
the problem and will now have a closer look at its periodic activity..

Ingo
