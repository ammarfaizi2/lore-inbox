Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRITTz4>; Thu, 20 Sep 2001 15:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272723AbRITTzs>; Thu, 20 Sep 2001 15:55:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28655 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S266488AbRITTzh>; Thu, 20 Sep 2001 15:55:37 -0400
Message-ID: <3BAA49B5.E02FA5E7@mvista.com>
Date: Thu, 20 Sep 2001 12:55:33 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
CC: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [PATCH] latency-profiling
In-Reply-To: <200109200609.f8K69uQ26778@mailc.telia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Larsson wrote:
> 
> Hi,
> 
> I ported my old latency-profiling patch to 2.4.10-pre10 with
> the reschedulable kernel patch. (I have not checked that it is
> preemption safe itself...)
> 
> This patch works a little different from Robert Loves.
> Since it samples the execution location at ticks.
> It is possible to instrument an ordinary kernel too...

It gives experienced latencies rather than potential latencies, but more
important from the developer/maintainers point of view, "Robert Loves"
patch provides information on the bad guys, i.e. the reason for the long
latency, which, hopefully, will allow them to be addressed by competent
maintainers.

George
