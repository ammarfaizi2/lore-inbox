Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTLGGft (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 01:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTLGGfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 01:35:48 -0500
Received: from holomorphy.com ([199.26.172.102]:8920 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262086AbTLGGfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 01:35:47 -0500
Date: Sat, 6 Dec 2003 22:35:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: john moser <bluefoxicy@linux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory Managment idea to help move things to userspace
Message-ID: <20031207063543.GO19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	john moser <bluefoxicy@linux.net>, linux-kernel@vger.kernel.org
References: <20031207061944.2D005E4B9@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031207061944.2D005E4B9@sitemail.everyone.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 10:19:44PM -0800, john moser wrote:
> I've been told there's issues with transferring huge amounts of data
> between kernelspace and userspace.  I think I may have a solution,
> if this problem does indeed exist.  This would make things such as
> userspace netfiltering and userspace network filesystem drivers
> extremely feasable by effectively eliminating all data transfer
> overhead to and from the kernel in a secure and efficient manner.
> PLEASE read and review this.  If it is complete and utter braindamage
> and simply not possible, please explain why, and discard.  If it IS
> good, then please plan to impliment in 2.7/2.8 (I realize I'm too
> late for 2.6).  If it's close but not quite there, FIX IT.  It's just
> an idea.

Efficient data transfer and mechanisms have been built up over time on
a case by case basis already without sacrificing security or reliability
in exchange for performance.

In general, ideas for these kind of things need to be backed up by code
in some form to be credible. For instance, known prior implementations
and prototype implementations are two kinds of code to back things up with.


-- wli
