Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUCPBAC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbUCPA7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:59:48 -0500
Received: from gprs40-147.eurotel.cz ([160.218.40.147]:39820 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263126AbUCPA4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:56:30 -0500
Date: Tue, 16 Mar 2004 01:56:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Remove pmdisk from kernel
Message-ID: <20040316005618.GB1883@elf.ucw.cz>
References: <20040315195440.GA1312@elf.ucw.cz> <20040315125357.3330c8c4.akpm@osdl.org> <20040315205752.GG258@elf.ucw.cz> <20040315132146.24f935c2.akpm@osdl.org> <1079379519.5350.20.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079379519.5350.20.camel@calvin.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Most of those changes are hooks to make the freezer for more reliable.
> That part of the functionality could be isolated from the bulk of
> suspend2. Would that make you happy?

Yes, that would be very good. It would make it easy to see actual
changes..

[I still do not understand why those hooks are neccessary... kill
-SIGSTOP works, right?]
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
