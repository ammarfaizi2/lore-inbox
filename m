Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbTIOSak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 14:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbTIOSak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 14:30:40 -0400
Received: from ns.suse.de ([195.135.220.2]:11423 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261232AbTIOSaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 14:30:39 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <200309150632.h8F6WnHb000589@81-2-122-30.bradfords.org.uk.suse.lists.linux.kernel>
	<1063611650.2674.1.camel@dhcp23.swansea.linux.org.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Sep 2003 20:29:45 +0200
In-Reply-To: <1063611650.2674.1.camel@dhcp23.swansea.linux.org.uk.suse.lists.linux.kernel>
Message-ID: <p73vfrtoqg6.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Its kind of irrelevant when by saying "Athlon" you've added 128 byte
                                        ^^^^^^^
> alignment to all the cache friendly structure padding. There are systems
> where memory matters, but spending a week chasing 300 bytes when you can
> knock out 50K is a waste of everyones time. Do the 40K problems first

I suspect Alan meant "P4" above, Athlon only adds 64byte padding.
Default is 32 byte for 686.

But it's interesting how a typo can serve as a basis for much further
discussion in this thread @)

-Andi
