Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTKYAFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTKYAFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:05:34 -0500
Received: from ns.suse.de ([195.135.220.2]:1504 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261758AbTKYAF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:05:27 -0500
Date: Tue, 25 Nov 2003 01:05:26 +0100
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
Message-ID: <20031125000526.GD28026@wotan.suse.de>
References: <20031124224514.56242.qmail@web40908.mail.yahoo.com.suse.lists.linux.kernel> <Pine.LNX.4.58.0311241452550.15101@home.osdl.org.suse.lists.linux.kernel> <p733ccdpbra.fsf@oldwotan.suse.de> <20031125000002.GB1586@mis-mike-wstn.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125000002.GB1586@mis-mike-wstn.matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Me and Chris used that to track down some nasty corruptions on x86-64,
> > it is especially useful together with LTP which calls a lot of system
> > calls that could cause corruption.
> 
> Do you have your code posted anywhere, and when are you going to merge it
> with LTP? ;)

I wrote it always custom tailored to the problem (it is not very difficult, but
you often have to tune it a bit until it has the right frequency to find the
corruption) Don't have one here right now, sorry.  Chris had a aimed to be 
generic patch for 2.4 that may still be around. I don't think it would fit 
into current LTP because it is an kernel module (LTP doesn't have a kernel build 
infrastructure right now).  But it would be an useful addition longer term to it 
I agree, once they support kernel modules.

-Andi

