Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945898AbWBOJIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945898AbWBOJIv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 04:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423062AbWBOJIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 04:08:51 -0500
Received: from fmr23.intel.com ([143.183.121.15]:42400 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1423060AbWBOJIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 04:08:49 -0500
Message-Id: <200602150908.k1F98dg02934@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <hawkes@sgi.com>, "Tony Luck" <tony.luck@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Cc: "Jack Steiner" <steiner@sgi.com>, "Robin Holt" <holt@sgi.com>,
       "Dimitri Sivanich" <sivanich@sgi.com>, "Jes Sorensen" <jes@sgi.com>
Subject: RE: [PATCH] ia64: simplify and fix udelay()
Date: Wed, 15 Feb 2006 01:08:41 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYxlpO36D6DTV3ZRR2ojOGsacUNFQAdePGQ
In-Reply-To: <20060214184017.20492.48141.sendpatchset@tomahawk.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hawkes@sgi.com wrote on Tuesday, February 14, 2006 10:40 AM
> a preemption and migration to another CPU during the
> while-loop

Off topic from the subject line a bit, but related: how many Altix
SN2 customers in the field turn on CONFIG_PREEMPT? Redhat EL4 doesn't
turn on preempt, SuSE SLES9 and SLES10 beta don't turn it on either.
Is there a real benefit of turning that option on for SN2?

- Ken

