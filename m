Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbUEWPLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUEWPLv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 11:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUEWPLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 11:11:51 -0400
Received: from ozlabs.org ([203.10.76.45]:53641 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262960AbUEWPLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 11:11:50 -0400
Date: Mon, 24 May 2004 01:08:19 +1000
From: Anton Blanchard <anton@samba.org>
To: Gergely Czuczy <phoemix@harmless.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 VS 2.6 fork VS thread creation time test
Message-ID: <20040523150819.GB7659@krispykreme>
References: <Pine.LNX.4.60.0405230914330.15840@localhost> <40B066EC.1010107@yahoo.com.au> <Pine.LNX.4.60.0405231058530.25386@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0405231058530.25386@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It doesn't matter. That's why you should look at the "ratio" at the end
> and not on the pure numbers, they are just bonus "information"

Your experimental method leaves a _lot_ to be desired. It matters a
great deal. eg It would be worth reading up how wildly different atomic
operations are on different x86 chips:

http://www.labs.fujitsu.com/en/techinfo/linux/lse-0211/lse-0211.pdf

Anton
