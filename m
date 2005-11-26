Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbVKZDbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbVKZDbP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 22:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbVKZDbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 22:31:15 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:10892 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932690AbVKZDbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 22:31:14 -0500
Date: Sat, 26 Nov 2005 11:39:55 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
       levon@movementarian.org
Subject: Re: BUG: spinlock recursion on 2.6.14-mm2 when oprofiling
Message-ID: <20051126033955.GC7226@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	mingo@elte.hu, levon@movementarian.org
References: <20051118152101.GA4690@mail.ustc.edu.cn> <20051125220117.GA1836@us.ibm.com> <20051125232829.GA2405@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051125232829.GA2405@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2005 at 03:28:29PM -0800, Paul E. McKenney wrote:
> And here is an alternative patch that assumes that the answer to both
> questions above is "no".  It is shorter, though mostly due to use of
> the list_splice_init() and list_for_each_entry_safe() primitives.

Ok, I'll try it. But it may take time.

Currently I'm running oprofile on linux-2.6.15-rc2-mm1. It seems the bug is not
quite reproducible. I'll report again if there are any new findings.

Thanks,
Wu
