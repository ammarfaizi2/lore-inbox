Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbTEOOHR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTEOOHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:07:17 -0400
Received: from ms-smtp-02.southeast.rr.com ([24.93.67.83]:47753 "EHLO
	ms-smtp-02.southeast.rr.com") by vger.kernel.org with ESMTP
	id S264042AbTEOOHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:07:16 -0400
From: Boris Kurktchiev <techstuff@gmx.net>
Reply-To: techstuff@gmx.net
To: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: Posible memory leak!?
Date: Thu, 15 May 2003 10:24:36 -0400
User-Agent: KMail/1.5.1
References: <200305131415.37244.techstuff@gmx.net> <200305141012.53779.techstuff@gmx.net> <200305150545.h4F5j2u27109@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200305150545.h4F5j2u27109@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305151024.37040.techstuff@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday May 15 2003 1:51 am, Denis Vlasenko wrote:
> On 14 May 2003 17:12, Boris Kurktchiev wrote:
> > heh this is very interesting.... top b n1 reports this:
> > top - 10:08:24 up 16:36,  2 users,  load average: 0.16, 0.19, 0.08
> > Tasks:  62 total,   1 running,  60 sleeping,   0 stopped,   1 zombie
> > Cpu(s):  12.3% user,   5.1% system,   0.0% nice,  82.6% idle
> > Mem:    385904k total,   381572k used,     4332k free,   137244k
> > buffers Swap:   128512k total,    20012k used,   108500k free,
> > 126168k cached
>
> Typical. So what makes you think kernel leaks memory?

well the fact that before my swap was never used, and now .... I need to 
transcode something so I can show you how all swap is being used and non of 
the RAM (thus making programs run much slower, as is the case with 
transcode).

> BTW, which version of procps do you have? Mine is 2.0.10,
> 2.0.11 already exists.

I believe I have 2.0.10.

> gkrellm must be subtracting something from MemTotal trying
> to account for fact that large part of RAM is used as a cache.
> You may consult its source.

No... I forgot to tell it to count cache and buffers... 
