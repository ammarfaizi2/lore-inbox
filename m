Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266995AbUBMNN1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 08:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266998AbUBMNN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 08:13:27 -0500
Received: from zork.zork.net ([64.81.246.102]:44166 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S266995AbUBMNNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 08:13:12 -0500
To: Nagy Tibor <nagyt@otpbank.hu>
Cc: xela@slit.de, mochel@osdl.org, bmoyle@mvista.com, orc@pell.chi.il.us,
       linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM
References: <402CC114.8080100@dell633.otpefo.com>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Nagy Tibor <nagyt@otpbank.hu>, xela@slit.de, 
 mochel@osdl.org,  bmoyle@mvista.com,  orc@pell.chi.il.us,
 linux-kernel@vger.kernel.org
Date: Fri, 13 Feb 2004 13:12:48 +0000
In-Reply-To: <402CC114.8080100@dell633.otpefo.com> (Nagy Tibor's message of
 "Fri, 13 Feb 2004 13:20:36 +0100")
Message-ID: <6uvfmbktrj.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nagy Tibor <nagyt@otpbank.hu> writes:

> Hi,
>
> I am sorry, I have found your e-mail address in
> ./arch/i386/kernel/setup.c. I have the problem below since a year, and
> there is no solution yet. I guess, the problem is about e820. The
> problem exists in 2.4.x and also in 2.6.1.
>
> We have two Dell Poweredge servers, an older one (PowerEdge 6300) and a
> newer one (PowerEdge 6400). Both servers have 4GB RAM, but the Linux
> kernel uses about 500MB less memory in the newer machine.

I may be talking through my hat, but I think that in this case you
need to select the option for support of 64G highmem.  If I recall,
"4G highmem" refers not to the total amount to the memory, but to the
highest physical address that can be accessed.

