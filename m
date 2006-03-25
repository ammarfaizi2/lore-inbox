Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWCYHAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWCYHAr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 02:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWCYHAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 02:00:47 -0500
Received: from www.osadl.org ([213.239.205.134]:65497 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750814AbWCYHAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 02:00:46 -0500
Subject: Re: [PATCH] Call get_time() only when necessary in
	run_hrtimer_queue
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Dimitri Sivanich <sivanich@sgi.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, roe@sgi.com, steiner@sgi.com, clameter@sgi.com
In-Reply-To: <20060324142849.5cc27edb.akpm@osdl.org>
References: <20060324175136.GA10186@sgi.com>
	 <20060324142849.5cc27edb.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 08:01:26 +0100
Message-Id: <1143270086.5344.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 14:28 -0800, Andrew Morton wrote:
> This code has been extensively redone in -mm and I am planning on sending
> all that to Linus within a week.
> 
> The hrtimer rework in -mm might fix this performance problem, although from
> a quick peek, perhaps not.
> 
> So could you please verify that the problem still needs fixing in
> 2.6.16-mm1 and if so, raise a patch against that?

I have a look into it.

	tglx



