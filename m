Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268168AbUJDPQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268168AbUJDPQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUJDPQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:16:45 -0400
Received: from mail.tmr.com ([216.238.38.203]:27664 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268168AbUJDPQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:16:42 -0400
Date: Mon, 4 Oct 2004 11:09:04 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mmap() on cdrom files fails since 2.6.9-rc2-bk2
In-Reply-To: <20041003121645.GA19580@elte.hu>
Message-ID: <Pine.LNX.3.96.1041004105918.29298B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Oct 2004, Ingo Molnar wrote:


> it means you are running an older distro which was built with a gcc that
> doesnt generate PT_GNU_STACK signatures in binaries yet. On the biggest
> distros the transition to PT_GNU_STACK binaries coincided with the
> transition to a 2.6 kernel, so only people who run newer kernels on
> older distros are affected, which is relatively rare since most 'older
> distros' are not 2.6-ready in a number of system-support areas.
> (although the kernel itself of course must be able to run old code too.)

Perhaps the majority of people with "old distro" configurations are people
who followed the development kernels from machines which were nearly
current then. My primary test machine is (loosely) based on RH7.3, with
only the updates needed for 2.6 as it developed and of course any security
issuesI saw.

The lack of reported issues may be caused by people who survived the
development process being able to identify the majority of problems like
this as well as there not being a lot of old systems.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

