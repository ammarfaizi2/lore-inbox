Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbWAKBte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWAKBte (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWAKBtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:49:33 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:60603 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161076AbWAKBtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:49:33 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Martin Bligh <mbligh@google.com>
Subject: Re: -mm seems significanty slower than mainline on kernbench
Date: Wed, 11 Jan 2006 12:49:05 +1100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>
References: <43C45BDC.1050402@google.com> <20060110173159.55cce659.akpm@osdl.org> <43C4624D.4040604@google.com>
In-Reply-To: <43C4624D.4040604@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601111249.05881.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006 12:41 pm, Martin Bligh wrote:
> Seems to have gone wrong between 2.6.14-rc1-mm1 and 2.6.14-rc2-mm1 ?
> See http://test.kernel.org/perf/kernbench.moe.png for clearest effect.

The only new scheduler patch at that time was this:
+sched-modified-nice-support-for-smp-load-balancing.patch

which was Peter's modifications to my smp nice support. cc'ed Peter

I guess we need to check whether reversing this patch helps.

Con
