Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbUJYM0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbUJYM0t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbUJYM0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:26:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:34214 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261771AbUJYM0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:26:48 -0400
Date: Mon, 25 Oct 2004 07:26:28 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       karim@opersys.com
Subject: Re: [RFC][PATCH] Restricted hard realtime
Message-ID: <20041025122628.GA2400@sgi.com>
References: <20041023194721.GB1268@us.ibm.com> <20041023201724.GA23936@elte.hu> <20041024181842.GB1262@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041024181842.GB1262@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 11:18:42AM -0700, Paul E. McKenney wrote:
> Dimitri, one nit so far...   Why is sched_domain_dummy under two
> layers of #ifdef CONFIG_SMP?  Any reason why the attached patch
> would not be in order?
>
Paul, this specific code wasn't part of my original patch, but after
looking at it briefly, I believe this patch should make sense.

Dimitri
