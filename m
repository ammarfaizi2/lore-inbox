Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbUCOXis (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbUCOXis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:38:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:21207 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262727AbUCOXio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:38:44 -0500
Date: Mon, 15 Mar 2004 15:40:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kurt Garloff <garloff@suse.de>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: dynamic sched timeslices
Message-Id: <20040315154042.40c58c5b.akpm@osdl.org>
In-Reply-To: <20040315230950.GB4452@tpkurt.garloff.de>
References: <20040315224201.GX4452@tpkurt.garloff.de>
	<20040315225939.A23686@infradead.org>
	<20040315230950.GB4452@tpkurt.garloff.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff <garloff@suse.de> wrote:
>
> > I remember we had a more complete patch to allow tuning the scheduler
> > through sysctls in -mm once, though.  Questions is why that one wasn't
> > merged and if the same reasons apply to a 'light' version.
> 
> Hmm, I fail to remember unfortunately. Probably it had too many knobs.
> Andrew?

It had a zillion knobs, and was mainly for developers.

Your patch didn't come with any subjective or measured testing results.  In
theory, the scheduler should magically tune itself to the current workload.
If your patch is indeed necessary then this may point at a bug in the
current CPU scheduler.

Please tell us more...
