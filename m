Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUJNUz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUJNUz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUJNUyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:54:36 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:57861 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S267250AbUJNUcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:32:35 -0400
Date: Thu, 14 Oct 2004 13:32:15 -0700
To: Bill Huey <bhuey@lnxw.com>
Cc: Mark_H_Johnson@Raytheon.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
Message-ID: <20041014203215.GC17855@nietzsche.lynx.com>
References: <OF2289D554.769CEFC1-ON86256F2D.005DF70B-86256F2D.005DF791@raytheon.com> <20041014202633.GA17855@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014202633.GA17855@nietzsche.lynx.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 01:26:33PM -0700, Bill Huey wrote:
> On Thu, Oct 14, 2004 at 12:06:22PM -0500, Mark_H_Johnson@Raytheon.com wrote:
> > I also managed to get the machine stuck with
> >   /sbin/reboot
> > not sure why.

> Mount the file system read/write and start slamming it with heavy disk
> activity. If it locks up, then it might just as well be a problem with
> the journaling code and the softirq system backing it. I ran into this
> in my project and it was the softirq related IO code all of the way down
> to the SCSI driver.

Heavy "sync" activity killed my machine. Try stuff that puts loads on
that system. :)

bill

