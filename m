Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTIFAPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 20:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTIFAPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 20:15:00 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:11904
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262719AbTIFAPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 20:15:00 -0400
Date: Fri, 5 Sep 2003 20:14:44 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.6.0-test4-mm6
In-Reply-To: <20030905015927.472aa760.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0309051220290.31201@montezuma.fsmlabs.com>
References: <20030905015927.472aa760.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Sep 2003, Andrew Morton wrote:

>   We didn't get many reports from this in -mm5.  I'd prefer to stick with
>   Con's patches because they're tweaks, rather than fundamental changes and
>   they have had more testing and are more widely understood.
> 
>   But the performance regressions with specjbb and volanomark are a
>   problem.  We need to understand this and get it fixed up.

I believe Con has a lead on this already, the thing to find out is why 
sched_clock() causes such a regression.
