Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTLECut (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 21:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbTLECut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 21:50:49 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15493
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263834AbTLECus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 21:50:48 -0500
Date: Fri, 5 Dec 2003 03:51:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa1
Message-ID: <20031205025109.GB1565@dualathlon.random>
References: <20031205022225.GA1565@dualathlon.random> <20031205023811.GK29119@mis-mike-wstn.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205023811.GK29119@mis-mike-wstn.matchmail.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 06:38:11PM -0800, Mike Fedyk wrote:
> On Fri, Dec 05, 2003 at 03:22:25AM +0100, Andrea Arcangeli wrote:
> > Only in 2.4.23pre6aa3: 90_ext3-commit-interval-5
> > 
> > 	Obsoleted by the laptop mode (I hope it's "fully" obsoleted ;).
> > 
> 
> Maybe not.  I saw one report here on lkml that showed that
> ext3-commit-interval is still needed even with laptop mode. :(

It would be a bug of the laptop mode patch merged in mainline in such
case.  I tracked related changes in ext3, so I assumed it was just
covered. If it isn't covered, laptop mode will be useless because the hd
will never go to sleep ;)
