Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266148AbUF3ATZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266148AbUF3ATZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 20:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUF3ATZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 20:19:25 -0400
Received: from palrel10.hp.com ([156.153.255.245]:6821 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S266148AbUF3ATR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 20:19:17 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16610.1785.803565.312232@napali.hpl.hp.com>
Date: Tue, 29 Jun 2004 17:19:05 -0700
To: KOVACS Krisztian <hidden@balabit.hu>
Cc: David Mosberger <davidm@napali.hpl.hp.com>,
       Balazs Scheidler <bazsi@balabit.hu>, linux-kernel@vger.kernel.org
Subject: Re: kernel oops on ia64 (2.6.6 + 0521 ia64 patch)
In-Reply-To: <1087896874.2358.12.camel@nienna.balabit>
References: <1087420973.4345.19.camel@bzorp.balabit>
	<16592.60876.886257.165633@napali.hpl.hp.com>
	<1087489727.30553.0.camel@bzorp.balabit>
	<16593.62204.126371.863028@napali.hpl.hp.com>
	<1087896874.2358.12.camel@nienna.balabit>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 22 Jun 2004 11:34:34 +0200, KOVACS Krisztian <hidden@balabit.hu> said:

  KOVACS>   No, it still dies while running the ./configure script...

Hmmh, that almost sounds to me like the hardware might be flaky.
Strange though that it would work with an SMP kernel.  I use UP
kernels a lot on my home machine (zx2000) so what you're seeing
certainly seems unusual.  Can you try with the latest linux-ia64-2.5
repository?  If that doesn't work, I guess we'll have to sit down and
look into what's different about your setup/configuration.

	--david
