Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbVLATxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVLATxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVLATxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:53:41 -0500
Received: from cantor2.suse.de ([195.135.220.15]:10665 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932426AbVLATxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:53:40 -0500
Date: Thu, 1 Dec 2005 20:53:39 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86_64: Display HPET timer option
Message-ID: <20051201195339.GA997@wotan.suse.de>
References: <Pine.LNX.4.64.0512011143350.13220@montezuma.fsmlabs.com> <Pine.LNX.4.64.0512011150110.3099@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512011150110.3099@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 11:50:31AM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 1 Dec 2005, Zwane Mwaikambo wrote:
> >
> > Currently the HPET timer option isn't visible in menuconfig.
> 
> Do you want it to?
> 
> Why would you ever compile it out?

I don't see any reason for it neither. It would probably only
cause problems because such an option would inevitably bitrot
regularly.

Also the HPET code in x86-64 isn't even ifdefed right now,
so you can't do that.

-Andi
