Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVBYCQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVBYCQb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 21:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVBYCQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 21:16:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37322 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262349AbVBYCQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 21:16:26 -0500
Date: Thu, 24 Feb 2005 18:16:19 -0800
Message-Id: <200502250216.j1P2GJrL016564@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Chris Wright <chrisw@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] override RLIMIT_SIGPENDING for non-RT signals
In-Reply-To: Chris Wright's message of  Thursday, 24 February 2005 18:12:09 -0800 <20050225021209.GU15867@shell0.pdx.osdl.net>
X-Windows: warn your friends about it.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, it fixes the issue, but opens the door to larger consumption of
> pending signals.  Roland, what was your final preference?  I'm kind of
> leaning towards Jeremy's original patch.

It's not a matter of preference.  As I said in the first place, without my
patch we are violating POSIX, and delivering unreliable results to users.


Thanks,
Roland
