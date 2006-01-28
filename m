Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWA1TNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWA1TNl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 14:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWA1TNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 14:13:41 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:36624 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750725AbWA1TNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 14:13:40 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ken MacFerrin <lists@macferrin.com>
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
Date: Sat, 28 Jan 2006 19:13:50 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <43DAE307.5010306@macferrin.com>
In-Reply-To: <43DAE307.5010306@macferrin.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601281913.50169.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 January 2006 03:20, Ken MacFerrin wrote:
> I started getting hard lockups on my desktop PC with the error "kernel
> BUG at mm/rmap.c:487" starting with kernel 2.6.13 and continuing through
> 2.6.14.  After switching to 2.6.15 the lockups have continued with the
> message "kernel BUG at mm/rmap.c:486".
>
> The frequency and circumstance are completely random which originally
> had me suspecting bad memory but after running Memtest86+ for over 12
> hours without error I'm at a loss.
>
> I'm running the binary Nvidia driver so I'll understand if I can't get
> help here but in searching through the list archives it would seem I'm
> not alone and I am willing to try any patches that may help diagnose the
> issue.  The crash happens at least daily and I've seen no difference in
> running kernels with or without PREEMPT enabled.
>
> The machine is a P4 3.00GHz with 2048MB PC3200 Unbuffered RAM on an ASUS
> motherboard with an ICH5 chipset.  XFX GF 6600GT video card, 600W power
> supply and plenty of cooling.

Ken,

Just to let you know, I've had the same problem on x86-64. It's an incredibly 
rare fault here and I've not been able to reproduce it. However, I cannot 
help but notice that all of the reporters so far have been running the binary 
NVIDIA driver, including myself.

I would not be surprised if running without the NVIDIA driver eliminated the 
problem.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
