Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWCYOHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWCYOHo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 09:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWCYOHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 09:07:44 -0500
Received: from www.osadl.org ([213.239.205.134]:11486 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751412AbWCYOHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 09:07:44 -0500
Subject: Re: Comment on 2.6.16-rt6 PI
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0603232131110.6809-200000@lifa01.phys.au.dk>
References: <Pine.LNX.4.44L0.0603232131110.6809-200000@lifa01.phys.au.dk>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 15:08:23 +0100
Message-Id: <1143295703.5344.120.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-25 at 14:52 +0100, Esben Nielsen wrote:

> In my test setup this leaves the owner->pi_waiters empty even though there
> are waiters. I tried to move the removal of top_waiter inside the second
> if statement but then a lot of other tests failed. I don't have time to
> fix it.

Can you please explain that more detailed how it happens ? And provide a
test case ?

	tglx


