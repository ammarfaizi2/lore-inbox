Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273032AbTHKSob (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273052AbTHKSnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:43:17 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:29939 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S273032AbTHKSmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:42:47 -0400
Date: Mon, 11 Aug 2003 11:37:07 -0700
From: Chris Wright <chris@wirex.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SE Linux as module?
Message-ID: <20030811113707.A25237@figure1.int.wirex.com>
References: <200308112125.04257.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200308112125.04257.arvidjaar@mail.ru>; from arvidjaar@mail.ru on Mon, Aug 11, 2003 at 09:25:04PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrey Borzenkov (arvidjaar@mail.ru) wrote:
> config does not suggest building it as module. Is it not possible by design?

That's correct.  The SELinux module needs to take advantage of early
initialization of all security labels, and thus must be compiled into
the kernel statically.

thanks
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
