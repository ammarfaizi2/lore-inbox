Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUBREIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbUBREH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:07:56 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:32181 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263101AbUBREHV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:07:21 -0500
Message-ID: <4032E4F0.8080307@cyberone.com.au>
Date: Wed, 18 Feb 2004 15:07:12 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Christoph Stueckjuergen <christoph.stueckjuergen@siemens.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 Scheduler Latency Measurements (Preemption diabled/enabled)
References: <200402031724.17994.christoph.stueckjuergen@siemens.com> <4032DEEA.1060007@tmr.com>
In-Reply-To: <4032DEEA.1060007@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bill Davidsen wrote:

> Christoph Stueckjuergen wrote:


snip

>>
>> PS: I am not subscribed, please CC me if you answer!
>
>
> Have you considered repeating your test on 2.6.3-rc3-mm1 or similar 
> with all of the most recent thinking on scheduling?
>

They shouldn't make a difference here. Christoph is using
realtime scheduling, so he's really measuring preempt off
time + context switch overhead. The actual scheduler can't
really help here.


