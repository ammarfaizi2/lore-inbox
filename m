Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbTFAElu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 00:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTFAElu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 00:41:50 -0400
Received: from almesberger.net ([63.105.73.239]:38150 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261241AbTFAElt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 00:41:49 -0400
Date: Sun, 1 Jun 2003 01:53:31 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, procps-list@redhat.com,
       kernel@theoesters.com, rml@tech9.net, miquels@cistron-office.nl,
       xose@wanadoo.es, tab@tuxfamily.org
Subject: Re: [announce] procps 2.0.13 with NPTL enhancements
Message-ID: <20030601015331.A8352@almesberger.net>
References: <1054270854.22088.617.camel@cube> <20030530062635.GM5643@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030530062635.GM5643@fs.tum.de>; from bunk@fs.tum.de on Fri, May 30, 2003 at 08:26:36AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Disabling the proc filesystem is simple by unchecking one item in the 
> kernel config menu and different from taking out "a chunk of libc" it's 
> more or less supported.

It's worse: if a system is brought up for reduced operation, e.g.
with init=/bin/sh for repair work, it is not uncommon for /proc to
be absent.

Since it is not immediately obvious for a user whether a given
program depends on /proc or not, just crashing in such a situation
is clearly a case poor user interface design.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
