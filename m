Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUHBI0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUHBI0o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 04:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266358AbUHBI0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 04:26:44 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:35273 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266352AbUHBI0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 04:26:43 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040802073938.GA8332@elte.hu>
References: <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <1091141622.30033.3.camel@mindpipe> <20040730064431.GA17777@elte.hu>
	 <1091228074.805.6.camel@mindpipe> <1091234100.1677.41.camel@mindpipe>
	 <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com>
	 <1091403477.862.4.camel@mindpipe> <1091407585.862.40.camel@mindpipe>
	 <20040802073938.GA8332@elte.hu>
Content-Type: text/plain
Message-Id: <1091435237.3024.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 02 Aug 2004 04:27:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-02 at 03:39, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > If we have any suspects for the code paths involved, couldn't this be
> > verified by adding a udelay(10) to the path, and verifying that the
> > hump moves by 10?  This technique could also be used to distinguish
> > different code paths with similar execution times.  It looks like they
> > are finite and few in number.
> 
> i believe wli's latency-timing patch gives a pretty good indication of
> the code path(s) involved - i'm using something quite similar to that. 
> The printout triggers immediately at the end of a high latency, so the
> stack contains a number of clues about what went on before.
> 

Can you post this patch, or add it to the voluntary preempt series?  The
one posted several weeks ago worked for me but had to be applied
manually and has probably been improved since.

Just to clarify the last numbers I posted were for O2.

Lee

