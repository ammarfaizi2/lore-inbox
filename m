Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291664AbSB0Cd2>; Tue, 26 Feb 2002 21:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291689AbSB0CdT>; Tue, 26 Feb 2002 21:33:19 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:28663 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S291664AbSB0CdC>; Tue, 26 Feb 2002 21:33:02 -0500
Message-ID: <3C7C4520.2783D895@mvista.com>
Date: Tue, 26 Feb 2002 18:32:00 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: wwp <subscript@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: low latency & preemtible kernels
In-Reply-To: <20020226141144.248506fa.subscript@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wwp wrote:
> 
> Hi there,
> 
> here's a newbie question:
> is it UNadvisable to apply both preempt-kernel-rml and low-latency patches
> over a 2.4.18 kernel?
> 
> thanx in advance
> 
> --
I believe that the preempt kernel patch or one related to it does the
low-latency stuff in a more economical way, i.e. takes advantage of the
preemption code to implement the low-latency stuff.  See the lock-break
patch that rml has.  It should be right next to the preempt patch.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
