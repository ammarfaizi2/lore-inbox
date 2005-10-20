Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbVJTPXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbVJTPXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 11:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbVJTPXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 11:23:39 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:60887 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751510AbVJTPXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 11:23:39 -0400
Date: Thu, 20 Oct 2005 11:23:27 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <Pine.LNX.4.58.0510201109170.30996@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510201122390.30996@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
 <1129734626.19559.275.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.58.0510201031270.30996@localhost.localdomain>
 <Pine.LNX.4.58.0510201109170.30996@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Oct 2005, Steven Rostedt wrote:

>
> Also, after the machine rebooted into Ingo's -rt13 it hit a NMI watchdog
> detected lockup on bootup.  This looks like a false positive since this
> was spit out without any pause.
>

My mistake, there is a pause, I just didn't notice it the first time. So
this is probably not a false positive.

-- Steve

