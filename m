Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVCWFqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVCWFqb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 00:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVCWFqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 00:46:31 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:35743 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261437AbVCWFq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 00:46:29 -0500
Date: Tue, 22 Mar 2005 21:46:38 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: "Magnus Naeslund(t)" <mag@fbab.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-01
Message-ID: <20050323054638.GD1294@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <423F5456.5010908@fbab.net> <20050322054025.GA1296@us.ibm.com> <42402428.8040506@fbab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42402428.8040506@fbab.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 02:56:56PM +0100, Magnus Naeslund(t) wrote:
> Paul E. McKenney wrote:
> >
> >Hello, Magnus,
> >
> >I believe that my earlier patch might take care of this (included again
> >for convenience).
> >
> >						Thanx, Paul
> >
> 
> I just tested this patch, and it did not solve my problem.
> The dst cache still grows to the maximum and starts spitting errors via 
> printk.
> 
> I'll do a make mrproper build too to make sure I didn't make any mistakes.

Hello, Magnus,

I have at least two other bugs that would be fatal.  Having learned a
bit more about PREEMPT_RT in this thread, I need to go off and dig through
my code for similar problems.

						Thanx, Paul
