Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267777AbUJRT74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267777AbUJRT74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUJRTzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:55:16 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:10002 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S267730AbUJRTww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:52:52 -0400
Date: Mon, 18 Oct 2004 12:52:25 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041018195225.GB23217@nietzsche.lynx.com>
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041018193251.GA15313@nietzsche.lynx.com> <20041018193603.GB8159@elte.hu> <20041018194040.GC15313@nietzsche.lynx.com> <20041018194632.GB9550@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018194632.GB9550@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 09:46:32PM +0200, Ingo Molnar wrote:
> since 2.6.9's release is imminent there will unlikely be an -rc4-mm2,
> 2.6.9-mm1 should be the next one.

The new kgdb logic is a bit foreign to me. I'll have to look at it a
bit more, but this kgdb build problem is criticial for a certain
part of the kernel community that needs it. I've commented out that
section and rebuilding it now.

To get kgdb work (referencing my tree), I've just demoted all of the
spinlocks in arch/i386/{kernel,lib}/kgdb*.c files. It's pretty straight
forward, nothing tricky at all.

bill

