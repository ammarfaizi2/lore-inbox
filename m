Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTILOYO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 10:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbTILOYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 10:24:14 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:4090 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S261706AbTILOYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 10:24:13 -0400
Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
From: Martin Schlemmer <azarah@gentoo.org>
To: richard.brunner@amd.com
Cc: LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>
In-Reply-To: <99F2150714F93F448942F9A9F112634C0638B197@txexmtae.amd.com>
References: <99F2150714F93F448942F9A9F112634C0638B197@txexmtae.amd.com>
Content-Type: text/plain
Message-Id: <1063376046.3376.188.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 12 Sep 2003 16:14:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-11 at 06:55, richard.brunner@amd.com wrote:
> Jun,
> 
> I have to agree with what Andi says. It is in a slow path,
> and we want to guard against user programs that could hit it.
> Making it conditional doesn't buy a lot and would cause lots of
> re-validation of the patch that we would like
> to avoid so we can get this in to the 2.6 kernel ASAP. 
> Don't worry! I am pretty certain the patch won't impact the 
> performance of the 2.6 kernel on processors from other vendors ;-)
> 

Would be nice if somebody with more knowledge about all the
benchmarks and a few non AMD processor machines could test
to see if its really that non critical (*hint* *hint*).  Yes,
I am not a kernel dev, but I do know that one or two slowdowns
in an already slow path is not that critical - problem now is
just that 5 or 6 might be an issue =)


Thanks,

-- 
Martin Schlemmer


