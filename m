Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbULOExc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbULOExc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 23:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbULOExc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 23:53:32 -0500
Received: from news.suse.de ([195.135.220.2]:64463 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261876AbULOEvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 23:51:12 -0500
Date: Wed, 15 Dec 2004 05:51:11 +0100
From: Andi Kleen <ak@suse.de>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] cpu-timers: high-resolution CPU clocks for POSIX clock_* syscalls
Message-ID: <20041215045111.GG27225@wotan.suse.de>
References: <200412140355.iBE3t7KL008040@magilla.sf.frob.com.suse.lists.linux.kernel> <p73zn0gzojo.fsf@bragg.suse.de> <a36005b50412141444432cb6c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b50412141444432cb6c1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 02:44:17PM -0800, Ulrich Drepper wrote:
> On 14 Dec 2004 20:07:39 +0100, Andi Kleen <ak@suse.de> wrote:
> 
> > I don't think this should be merged until a clear need from a useful
> > application is demonstrated for it.
> 
> This is something which is requested countless times.  Everybody doing
> development of sophisticated programs adds some kind of self
> monitoring.  And there is of course profiling.  The most widely used

You mean statistical profiling? I don't see why you need a bigger
resolution than HZ for that. 

> program which needs this is probably the JVM.  Don't ask me for the
> specific class, but the JVM developers asked for these clocks in this
> form.  Without the support available the Linux JVM is never going to

They didn't ask linux-kernel at least. Perhaps their requirements
should be discussed here first before messing up all kinds of
fast paths with dubious changes? 

-Andi
