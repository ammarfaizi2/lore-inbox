Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269388AbUINSrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269388AbUINSrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269489AbUINSpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:45:20 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:43751 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S269366AbUINSoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:44:22 -0400
Date: Tue, 14 Sep 2004 11:40:05 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: ak@suse.de, dipankar@in.ibm.com, maneesh@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Add rcu_assign_pointer() to kill more memory barriers
Message-ID: <20040914184005.GC1237@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040907223037.GA13346@us.ibm.com> <20040914100856.528bd6c9@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914100856.528bd6c9@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 10:08:56AM -0700, Stephen Hemminger wrote:
> Looks good, memory barriers are the second major source of confusion
> for many developers (after locking).

Glad you like it!  It passed kernbench on a 4-way x86 box, FYI!

						Thanx, Paul
