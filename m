Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUHSQk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUHSQk1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUHSQk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:40:27 -0400
Received: from palrel13.hp.com ([156.153.255.238]:21145 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263847AbUHSQkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:40:24 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16676.55284.896783.567359@napali.hpl.hp.com>
Date: Thu, 19 Aug 2004 09:40:20 -0700
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: kernbench on 512p
In-Reply-To: <200408191237.16959.jbarnes@engr.sgi.com>
References: <200408191216.33667.jbarnes@engr.sgi.com>
	<16676.54657.220755.148837@napali.hpl.hp.com>
	<200408191237.16959.jbarnes@engr.sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 19 Aug 2004 12:37:16 -0400, Jesse Barnes <jbarnes@engr.sgi.com> said:

  Jesse> On Thursday, August 19, 2004 12:29 pm, David Mosberger wrote:
  >> >>>>> On Thu, 19 Aug 2004 12:16:33 -0400, Jesse Barnes >>>>>
  >> <jbarnes@engr.sgi.com> said:
  >> 
  Jesse> It would be nice if the patch to show which lock is contended
  Jesse> got included.
  >>  Why not use q-syscollect?  It will show you the caller of
  >> ia64_spinlock_contention, which is often just as good (or better
  >> ;-).

  Jesse> Because it requires guile and guile SLIB, which I've never
  Jesse> been able to setup properly on a RHEL3 based distro.  Care to
  Jesse> rewrite the tools in C or something? ;)

Why not file a bug-report to Red Hat instead?  guile v1.6 and the
guile-SLIB are quite old and rather standard.

Of course, you could also run the analysis on a Debian system, which
comes standard with those packages.

	--david

