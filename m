Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266677AbUHSQaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266677AbUHSQaK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUHSQaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:30:09 -0400
Received: from palrel10.hp.com ([156.153.255.245]:26599 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S266677AbUHSQ36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:29:58 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16676.54657.220755.148837@napali.hpl.hp.com>
Date: Thu, 19 Aug 2004 09:29:53 -0700
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernbench on 512p
In-Reply-To: <200408191216.33667.jbarnes@engr.sgi.com>
References: <200408191216.33667.jbarnes@engr.sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 19 Aug 2004 12:16:33 -0400, Jesse Barnes <jbarnes@engr.sgi.com> said:

  Jesse> It would be nice if the patch to show which lock is contended
  Jesse> got included.

Why not use q-syscollect?  It will show you the caller of
ia64_spinlock_contention, which is often just as good (or better ;-).

	--david
