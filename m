Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268296AbTGLSvv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 14:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268304AbTGLSvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 14:51:51 -0400
Received: from RJ161046.user.veloxzone.com.br ([200.149.161.46]:50420 "EHLO
	mf.dnsalias.org") by vger.kernel.org with ESMTP id S268296AbTGLSvt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 14:51:49 -0400
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
From: Miguel Freitas <miguel@cetuc.puc-rio.br>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0307120922450.4351@bigblue.dev.mcafeelabs.com>
References: <1058017391.1197.24.camel@mf> 
	<Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com>
	<1058027672.1196.105.camel@mf> 
	<Pine.LNX.4.55.0307120922450.4351@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jul 2003 16:13:46 -0300
Message-Id: <1058037226.1196.122.camel@mf>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-12 at 13:30, Davide Libenzi wrote:
> > > Patch acceptance is
> > > tricky and definitely would need more discussion and test.
> >
> > Sure. But let me add a voice of support here: I would be great if kernel
> > provided a way to multimedia or interactive applications to request a
> > better latency predictability (or hint the scheduler somehow) without
> > need of being root. If that comes in a form of a new scheduler policy,
> > or just allowing small negative nice values for non-root i don't mind...
> 
> You'd need a nice value that will keep you away from being caught by
> interactive SCHED_OTHER. Otherwise yes, this is another solution. Did you
> try it with xine under high load ?

Since i upgraded my computer recently it's difficult to compare with the
experiments i made before. But basically no, i haven't tried to make
xine smooth under high load. my primary complain was that even a small
background load caused by KSysGuard (KDE system monitor) could make it
drop frames from time to time. with nice values like -2 the problem was
completely fixed.

regards,

Miguel

