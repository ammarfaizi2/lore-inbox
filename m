Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUHWJCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUHWJCq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 05:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267584AbUHWJCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 05:02:46 -0400
Received: from palrel10.hp.com ([156.153.255.245]:49831 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S267554AbUHWJCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 05:02:45 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16681.45746.300292.961415@napali.hpl.hp.com>
Date: Mon, 23 Aug 2004 02:02:42 -0700
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
In-Reply-To: <20040820200248.GJ11200@holomorphy.com>
References: <20040820031919.413d0a95.akpm@osdl.org>
	<200408201144.49522.jbarnes@engr.sgi.com>
	<200408201257.42064.jbarnes@engr.sgi.com>
	<20040820115541.3e68c5be.akpm@osdl.org>
	<20040820200248.GJ11200@holomorphy.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 20 Aug 2004 13:02:48 -0700, William Lee Irwin III <wli@holomorphy.com> said:

  William> I suppose another way to answer the question of what's
  William> going on is to fiddle with ia64's implementation of
  William> profile_pc(). I suspect something like this may reveal the
  William> offending codepaths.

You do realize that q-syscollect [1] can do this better for you
without touching the kernel at all?

	--david

[1] http://www.hpl.hp.com/research/linux/q-tools/
