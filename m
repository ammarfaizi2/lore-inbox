Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVASFLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVASFLy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 00:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVASFLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 00:11:53 -0500
Received: from palrel13.hp.com ([156.153.255.238]:17557 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261487AbVASFLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 00:11:50 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16877.60406.192245.106565@napali.hpl.hp.com>
Date: Tue, 18 Jan 2005 21:11:18 -0800
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: pipe performance regression on ia64
In-Reply-To: <41ED9D06.1070301@yahoo.com.au>
References: <200501181741.j0IHfGf30058@unix-os.sc.intel.com>
	<Pine.LNX.4.58.0501180951050.8178@ppc970.osdl.org>
	<41ED9D06.1070301@yahoo.com.au>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 19 Jan 2005 10:34:30 +1100, Nick Piggin <nickpiggin@yahoo.com.au> said:

  Nick> David I remember you reporting a pipe bandwidth regression,
  Nick> and I had a patch for it, but that hurt other workloads, so I
  Nick> don't think we ever really got anywhere. I've recently begun
  Nick> having another look at the multiprocessor balancer, so
  Nick> hopefully I can get a bit further with it this time.

While it may be worthwhile to improve the scheduler, it's clear that
there isn't going to be a trivial "fix" for this issue, especially
since it's not even clear that anything is really broken.  Independent
of the scheduler work, it would be very useful to have a pipe
benchmark which at least made the dependencies on the scheduler
obvious.  So I think improving the scheduler and improving the LMbench
pipe benchmark are entirely complementary.

	--david

