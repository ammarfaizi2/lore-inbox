Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268182AbUGWXp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268182AbUGWXp5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 19:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268183AbUGWXp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 19:45:57 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:43670 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S268182AbUGWXpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 19:45:54 -0400
Date: Sat, 24 Jul 2004 01:45:02 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Robert Wisniewski <bob@watson.ibm.com>
Cc: zanussi@us.ibm.com, linux-kernel@vger.kernel.org, karim@opersys.com,
       richardj_moore@uk.ibm.com, michel.dagenais@polymtl.ca
Subject: Re: LTT user input
Message-ID: <20040723234502.GA12631@k3.hellgate.ch>
Mail-Followup-To: Robert Wisniewski <bob@watson.ibm.com>,
	zanussi@us.ibm.com, linux-kernel@vger.kernel.org, karim@opersys.com,
	richardj_moore@uk.ibm.com, michel.dagenais@polymtl.ca
References: <16640.10183.983546.626298@tut.ibm.com> <20040723100101.GA22440@k3.hellgate.ch> <16641.19483.708016.320557@tut.ibm.com> <20040723191900.GA2817@k3.hellgate.ch> <16641.36290.751769.126111@k42.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16641.36290.751769.126111@k42.watson.ibm.com>
X-Operating-System: Linux 2.6.8-rc2-bk1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004 18:40:26 -0400, Robert Wisniewski wrote:
>  > Looking for a common base was certainly easier before one tracing
>  > framework got merged. I don't claim to know if a common basic framework
>  > would be beneficial, but I am somewhat amazed that not more effort has
>  > gone into exploring this.
> 
> Argh.  I had up to this point been passively following this thread because
> a while ago, prior to dtrace and other such work I, Karim, and others
> invested quite of bit of effort and time responding to this group pointing
> out the benefits of performance monitoring via tracing and
> 
> IN FACT this was exactly one of the points I ardently made.  Having each
> subsystem set up their own monitoring was not only counter productive in
> terms of time and implementation effort, but prevented a unified view of
> performance from being achieved.  Nevertheless, it appears that some

This may be somewhat of a misunderstanding: You seem to be talking about
a unified framework for performance monitoring -- something I silently
assumed should be the case, while the discussion here was about various
forms of logging -- with performance monitoring being one of them.

So the question is (again, this is an issue that has been raised at the
kernel summit as well): Is there some overlap between those various
frameworks? Or do we really need completely separate frameworks for
logging time stamps (performance), auditing information, etc.?

> proclaimed by dtrace.  As Karim has pointed out in previous posts, though
> the technical concerns that were raised were addressed, it didn't seem to
> help as other nits would crop up appearing to imply that something else was
> happening.

My postings were motivated by my personal interest in better tracing
and monitoring facilities. However, I'm getting LKCD flashbacks when
reading your arguments. Which doesn't bode well.

> If indeed the remaining issue is whether there is a benefit to
> a performance monitoring infrastructure, then I wonder how you would
> interpret reactions to dtrace.

DTrace is not a performance monitoring infrastructure, so what's your
point? -- But let's assume for the sake of argument that LTT, dprobes
& Co.  provide something comparable to DTrace, and we just disagree on
what "performance monitoring" means: The chance of getting such a pile
of complexity into mainline are virtually zero (unless it's called ACPI
and required to boot some machines :-/).

So what you can push for inclusion is bound to be a subset, and the
question remains: What does such a subset, which is clearly nothing
like DTrace, offer?

Roger
