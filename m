Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270338AbTGRTnB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 15:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270342AbTGRTnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 15:43:01 -0400
Received: from holomorphy.com ([66.224.33.161]:38791 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270338AbTGRTm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 15:42:57 -0400
Date: Fri, 18 Jul 2003 12:57:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Erich Focht <efocht@hpce.nec.com>, LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] [patch 2.6.0-test1] per cpu times
Message-ID: <20030718195747.GU8121@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mike Kravetz <kravetz@us.ibm.com>,
	Erich Focht <efocht@hpce.nec.com>,
	LSE <lse-tech@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200307181835.42454.efocht@hpce.nec.com> <20030718111850.C1627@w-mikek2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718111850.C1627@w-mikek2.beaverton.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 11:18:50AM -0700, Mike Kravetz wrote:
> On a somewhat related note ...
> We (Big Blue) have a performance reporting application that
> would like to know how long a task sits on a runqueue before
> it is actually given the CPU.  In other words, it wants to
> know how long the 'runnable task' was delayed due to contention
> for the CPU(s).  Of course, one could get an overall feel for
> this based on total runqueue length.  However, this app would
> really like this info on a per-task basis.
> Does anyone else think this type of info would be useful?
> A patch to compute/export this info should be straight forward
> to implement.

I wrote something to collect the standard queueing statistics a while
back but am not sure what I did with it. I think Rick Lindsley might
still have a copy around.


-- wli
