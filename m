Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWBMR1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWBMR1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWBMR1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:27:35 -0500
Received: from ns.suse.de ([195.135.220.2]:11230 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932365AbWBMR1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:27:34 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: Avuton Olrich <avuton@gmail.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Linux 2.6.16-rc3
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	<3aa654a40602130231p1c476e99paa986fa198951839@mail.gmail.com>
	<20060213023925.2b950eea.akpm@osdl.org>
	<200602132154.15187.kernel@kolivas.org>
From: Andi Kleen <ak@suse.de>
Date: 13 Feb 2006 18:27:22 +0100
In-Reply-To: <200602132154.15187.kernel@kolivas.org>
Message-ID: <p73accv41ad.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> On Monday 13 February 2006 21:39, Andrew Morton wrote:
> > That looks like a different cpufreq bug.  Unfortunately the critical first
> > few lines have scrolled away.  Please boot with `vga=extended' so we get to
> > see them.
> 
> Just as a suggestion, why don't we print oopsen out in the opposite direction 
> so the critical information is in the last few lines and the stacktrace in 
> reverse, or have that as a bootparam option oops=reverse .

x86-64 has a one line "executive summary" with the RIP etc. 
at the end to solve that problem. Might be a good idea for i386 too.

-Andi
