Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTJ1T75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 14:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTJ1T75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 14:59:57 -0500
Received: from hera.kernel.org ([63.209.29.2]:36745 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261664AbTJ1T74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 14:59:56 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: gettimeofday resolution seriously degraded in test9
Date: Tue, 28 Oct 2003 11:59:17 -0800
Organization: Open Source Development Lab
Message-ID: <20031028115917.124a76bf.shemminger@osdl.org>
References: <LphK.2Dl.15@gated-at.bofh.it>
	<Lq47.3Go.11@gated-at.bofh.it>
	<LqGL.4zF.11@gated-at.bofh.it>
	<LAPN.1dU.11@gated-at.bofh.it>
	<LGLz.1h2.5@gated-at.bofh.it>
	<ug8yn541c6.fsf@panda.mostang.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1067371143 27928 172.20.1.60 (28 Oct 2003 19:59:03 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 28 Oct 2003 19:59:03 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Oct 2003 11:19:21 -0800
David Mosberger-Tang <David.Mosberger@acm.org> wrote:

> >>>>> On Tue, 28 Oct 2003 19:30:13 +0100, Stephen Hemminger <shemminger@osdl.org> said:
> 
>   Stephen> This should work better. Patch against 2.6.0-test9
> 
> Why not use the time-interpolator interface defined in timex.h?  It
> should handle such things without any special hacks.
> 
> 	--david

Because it has not been used yet outside of ia64.  It would be worth investigating
post 2.6.0 if it could be shown to be as fast and more correct.  Several people
have talked about redoing the existing mess, but now is not the time to attack
this dragon...

