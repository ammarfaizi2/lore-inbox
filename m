Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTFKUGL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTFKUGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:06:11 -0400
Received: from h2.prohosting.com.ua ([217.106.231.81]:39092 "EHLO
	h2.prohosting.com.ua") by vger.kernel.org with ESMTP
	id S263752AbTFKUGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:06:01 -0400
From: Artemio <artemio@artemio.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP question
Date: Wed, 11 Jun 2003 23:13:30 +0300
User-Agent: KMail/1.5
References: <MDEHLPKNGKAHNMBLJOLKMEJLDJAA.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEJLDJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306112313.30903.artemio@artemio.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h2.prohosting.com.ua
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - artemio.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > How much performance will I loose this way? Is SMP *THAT* critical?
>
> 	You will lose about half your CPU power.

Hmmm... So, you mean uni-processor Linux kernel can't see two processors as 
one "big" processor? 

> >  - Run all tasks in a usual way, no hard realtime, but with SMP support.
> >
> > What would you suggest?
>
> 	If you don't install a kernel with SMP support, you might as well remove
> one processor.

:-)

> > Also, if I turn hyperthreading off, how will it influence the
> > system with SMP
> > support? Without SMP support?
>
> 	In a system with more than one physical CPU, hyperthreading is not that
> big of a performance boost.

Okay, I will try turning hyperthreding off and see if RTLinux keeps hanging 
the machine.


Thanks for your reply!

Artemio.
