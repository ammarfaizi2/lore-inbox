Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbTDMV6x (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 17:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTDMV6x (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 17:58:53 -0400
Received: from dhcp065-024-013-119.columbus.rr.com ([65.24.13.119]:24453 "EHLO
	united.lan.codewhore.org") by vger.kernel.org with ESMTP
	id S262005AbTDMV6w (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 17:58:52 -0400
Date: Sun, 13 Apr 2003 18:02:09 -0400
From: David Brown <dave@codewhore.org>
To: Robert Love <rml@tech9.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Preempt on PowerPC/SMP appears to leak memory
Message-ID: <20030413220209.GA5849@codewhore.org>
References: <20030412152951.GA10367@codewhore.org> <1050271044.767.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050271044.767.7.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 05:57:24PM -0400, Robert Love wrote:
| On Sat, 2003-04-12 at 11:29, David Brown wrote:
| 
| > I recently applied the preempt-kernel-rml-2.4.21-pre1-1.patch from
| > kernel.org to BenH's stable tree from rsync.penguinppc.org.
| 
| Oh, one other thing.  An updated patch for 2.4.20 is up:
| 
| http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.20-2.patch
| 
| It has a couple fixes for proper protection of per-CPU data, including
| some PPC-specific ones.
| 
| 	Robert Love

Hi Robert:

Thanks for the reply and the patch. I'll give the 2.4.20-2 patch a shot.
If I'm still seeing the leak after applying it, I'll do my best to track
it down (I already know it's somewhere in the fork() path, just based on
the mean-time-before-death of a few test scripts I was playing with).

I probably won't be able to isolate it down to a single line; I should,
however, be able to capture enough information so that someone with far
more awareness of the kernel's guts than I can track it down. :)


Thanks again,

- Dave

