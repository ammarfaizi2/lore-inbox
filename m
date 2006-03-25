Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWCYSep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWCYSep (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWCYSeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:34:44 -0500
Received: from www.osadl.org ([213.239.205.134]:42720 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932183AbWCYSeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:34:44 -0500
Subject: Re: Comment on 2.6.16-rt6 PI
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0603251912120.19918-100000@lifa01.phys.au.dk>
References: <Pine.LNX.4.44L0.0603251912120.19918-100000@lifa01.phys.au.dk>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 19:35:28 +0100
Message-Id: <1143311729.5344.131.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-25 at 19:23 +0100, Esben Nielsen wrote:
> Sorry for the lack of details. I just thought the test-case wouldn't make
> sense to you much and didn't paste it in. I was in a bit of a hurry too.
> Now I have a little more time and can tell you what is going on:
> 
> top_waiter!=NULL
> waiter!=NULL
> waiter!=rt_mutex_top_waiter(lock)
> 
> Therefore one top_waiter is removed and but nothing is inserted.

How does this happen. From inside the loop this is impossible. And I
dont see a caller with that constellation either.

	tglx


