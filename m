Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbUKENIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbUKENIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 08:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbUKENIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 08:08:20 -0500
Received: from cantor.suse.de ([195.135.220.2]:6021 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262670AbUKENIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 08:08:17 -0500
Date: Fri, 5 Nov 2004 14:02:05 +0100
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041105130205.GG8349@wotan.suse.de>
References: <20041105001328.3ba97e08.akpm@osdl.org> <20041105121528.GA6921@elte.hu> <20041105122225.GA1287@wotan.suse.de> <200411051357.12599.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411051357.12599.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 01:57:12PM +0100, Rafael J. Wysocki wrote:
> On Friday 05 of November 2004 13:22, Andi Kleen wrote:
> > On Fri, Nov 05, 2004 at 01:15:28PM +0100, Ingo Molnar wrote:
> > > 
> > > next problem: the x64 kernel doesnt boot 32-bit userspace anymore. I'm 
> > > getting an endless stream of segfaults:
> > 
> > I bet that is caused by the flexmmap TASK_SIZE changes.  Can you revert
> > the 64bit flexmmap patch and see if that helps? 
> > 
> > I tested it before flexmmap and it worked for me.
> 
> If it's not changed from the version that went to discuss@x86-64.org, flexmmap 
> breaks 32-bit user land on x86-64.  I've already reported it.

It didn't for me when I tested it without 4levels.

-Andi
