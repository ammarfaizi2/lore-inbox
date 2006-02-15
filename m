Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945968AbWBOO4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945968AbWBOO4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 09:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945966AbWBOO4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 09:56:22 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:30879 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1945963AbWBOO4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 09:56:21 -0500
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: <hawkes@sgi.com>, "Tony Luck" <tony.luck@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "Jack Steiner" <steiner@sgi.com>,
       "Robin Holt" <holt@sgi.com>, "Dimitri Sivanich" <sivanich@sgi.com>
Subject: Re: [PATCH] ia64: simplify and fix udelay()
References: <200602150908.k1F98dg02934@unix-os.sc.intel.com>
From: Jes Sorensen <jes@sgi.com>
Date: 15 Feb 2006 09:56:20 -0500
In-Reply-To: <200602150908.k1F98dg02934@unix-os.sc.intel.com>
Message-ID: <yq0y80cy8kr.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ken" == Chen, Kenneth W <kenneth.w.chen@intel.com> writes:

Ken> hawkes@sgi.com wrote on Tuesday, February 14, 2006 10:40 AM
>> a preemption and migration to another CPU during the while-loop

Ken> Off topic from the subject line a bit, but related: how many
Ken> Altix SN2 customers in the field turn on CONFIG_PREEMPT? Redhat
Ken> EL4 doesn't turn on preempt, SuSE SLES9 and SLES10 beta don't
Ken> turn it on either.  Is there a real benefit of turning that
Ken> option on for SN2?

Ken,

Not sure if any do, however as long as it's a supported kernel option
then we ought to make sure the kernel is reliable under it. Who knows,
at some point some distro might even decide to switch it on as well
(as much as I would discourage doing so ;).

Cheers,
Jes
