Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbUCBW6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbUCBW6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:58:37 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:5692 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262184AbUCBW63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:58:29 -0500
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
References: <1vmPm-4lU-11@gated-at.bofh.it> <1vonq-6dr-37@gated-at.bofh.it>
	<1voGY-6vC-41@gated-at.bofh.it> <1vpjt-7dl-17@gated-at.bofh.it>
	<1vpCV-7wY-41@gated-at.bofh.it> <1vpWa-7Py-19@gated-at.bofh.it>
	<4045106D.8060902@tmr.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 02 Mar 2004 14:57:15 -0800
In-Reply-To: <4045106D.8060902@tmr.com>
Message-ID: <52d67urh6c.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Mar 2004 22:57:15.0746 (UTC) FILETIME=[B4E2EC20:01C400A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bill> Could you maybe go back to the initial report, which is that
    Bill> after poll() gets wrong status? It's nice to argue about
    Bill> where the process waits, but the issue is if it gets the
    Bill> same status with 2.4 and 2.6, and if not which one should be
    Bill> fixed.

I'm sure the problem is a buggy driver.  The original question
represents a complete misunderstanding of how poll() is implemented,
so it's no surprise that the driver breaks.

 - Roland



