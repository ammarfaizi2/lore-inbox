Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVCLVTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVCLVTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 16:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVCLVTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 16:19:15 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:32199 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262023AbVCLVSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 16:18:34 -0500
Subject: Re: spin_lock error in arch/i386/kernel/time.c on APM resume
From: Lee Revell <rlrevell@joe-job.com>
To: george@mvista.com
Cc: Andrew Morton <akpm@osdl.org>, "J. Bruce Fields" <bfields@fieldses.org>,
       Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <4233111A.5070807@mvista.com>
References: <20050312131143.GA31038@fieldses.org>
	 <4233111A.5070807@mvista.com>
Content-Type: text/plain
Date: Sat, 12 Mar 2005 16:18:31 -0500
Message-Id: <1110662312.7723.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-12 at 07:56 -0800, George Anzinger wrote:
> J. Bruce Fields wrote:
> > On APM resume this morning on my Thinkpad X31, I got a "spin_lock is
> > already locked" error; see below.  This doesn't happen on every resume,
> > though it's happened before.  The kernel is 2.6.11 plus a bunch of
> > (hopefully unrelated...) NFS patches.
> > 
> > Any ideas?
> > 
> Yesterday's night mare, todays bug :(
> 

Wait, so this is the same theoretical bug you discussed in the
do_timer_interrupt thread?

Wow, a real schroedinbug...

Lee

