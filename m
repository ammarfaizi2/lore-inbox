Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268875AbUHZMC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268875AbUHZMC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268724AbUHZL5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:57:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:39911 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268701AbUHZLzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:55:39 -0400
Date: Tue, 24 Aug 2004 23:49:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Erik Rigtorp <erik@rigtorp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make swsusp produce nicer screen output
Message-ID: <20040824214929.GA490@openzaurus.ucw.cz>
References: <20040820152317.GA7118@linux.nu> <20040823174217.GC603@openzaurus.ucw.cz> <20040823200858.GA4593@linux.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823200858.GA4593@linux.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, it looks nice, be sure to submit smooth version :-).
> I'm working on it :).

> > I'd leave dots here. Its usefull to see if it done something or not.
> 
> Well, it will display a spinning thingy that is updated every time
> shrink_all_memory(10000) returns. Maybe you want to see how much memory was
> freed?

Yes, it is quite important to see how many pages were freed even after
freeing stopped. "done (1234 pages freed)" would solve it...

> And do we need to handle the case when nr_copy_pages < 100?

It really should not crash. 100 pages is 4MB. Thats little low but
seems possible.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

