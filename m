Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbUKDBl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUKDBl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 20:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUKDBl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 20:41:58 -0500
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:28340 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S262040AbUKDBls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:41:48 -0500
From: Russell Miller <rmiller@duskglow.com>
To: Doug McNaught <doug@mcnaught.org>
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 20:45:20 -0500
User-Agent: KMail/1.7
Cc: Kurt Wall <kwall@kurtwerks.com>, linux-kernel@vger.kernel.org
References: <200411030751.39578.gene.heskett@verizon.net> <200411031901.28977.rmiller@duskglow.com> <87654m4clz.fsf@asmodeus.mcnaught.org>
In-Reply-To: <87654m4clz.fsf@asmodeus.mcnaught.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411031945.20894.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 19:38, Doug McNaught wrote:
> Russell Miller <rmiller@duskglow.com> writes:
> > This brings up another question I've had since reading the documentation
> > on later pentium-class chips:
> >
> > why are only rings 0 and 3 used in linux?
>
> Because the "traditional" Unix privilege model only has two levels,
> and Linux runs on many architectures, most of which have only two
> privilege levels (the 68000 called them "user" and "supervisor").
> Special-casing x86 is possible but probably wouldn't be worth it.
>
Wouldn't it help with device driver problems?  Couldn't ring 1 be used to make 
sure an errant driver doesn't drop the kernel, at least on x86 machines?

I remember the 68000 architecture.  Quite nice (but I was 10 when I studied 
it, so..).

--Russell

> -Doug

-- 

Russell Miller - rmiller@duskglow.com - Le Mars, IA
Duskglow Consulting - Helping companies just like you to succeed for ~ 10 yrs.
http://www.duskglow.com - 712-546-5886
