Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752574AbWKBIfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbWKBIfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbWKBIfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:35:23 -0500
Received: from [62.205.161.221] ([62.205.161.221]:19691 "EHLO sacred.ru")
	by vger.kernel.org with ESMTP id S1752574AbWKBIfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 03:35:22 -0500
Message-ID: <4549ADA2.5080404@openvz.org>
Date: Thu, 02 Nov 2006 11:34:42 +0300
From: Kir Kolyshkin <kir@openvz.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061001)
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>
CC: Kir Kolyshkin <kir@openvz.org>, devel@openvz.org, vatsa@in.ibm.com,
       dev@openvz.org, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       dipankar@in.ibm.com, rohitseth@google.com,
       Paul Menage <menage@google.com>, Chris Friesen <cfriesen@nortel.com>
Subject: Re: [Devel] Re: [ckrm-tech] [RFC] Resource Management -	Infrastructure
 choices
References: <20061030103356.GA16833@in.ibm.com>	 <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>	 <20061101173356.GA18182@in.ibm.com> <45490F0D.7000804@nortel.com>	 <45492764.6060700@openvz.org> <1162427497.12419.186.camel@localhost.localdomain>
In-Reply-To: <1162427497.12419.186.camel@localhost.localdomain>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0rc6 (sacred.ru [62.205.161.221]); Thu, 02 Nov 2006 11:35:05 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:
> On Thu, 2006-11-02 at 02:01 +0300, Kir Kolyshkin wrote:
>   
>> cpuunits 10, 20, and 30 assigned to containers X, Y, and Z, and run some
>> CPU-intensive tasks in all the containers, X will be given
>> 10/(10+20+30), or 20% of CPU time, Y -- 20/50, i.e. 40%, while Z gets
>>     
>
> nit: I don't think this math is correct.
>
> Shouldn't they all have the same denominator (60), or am I
> misunderstanding something?
>
> If so then it should be:
> X = 10/60      16.666...%
> Y = 20/60      33.333...%
> Z = 30/60      50.0%
> Total:        100.0%
>   
Ughm. You are totally correct of course, I must've been very tired
yesterday night :-\


