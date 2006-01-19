Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161335AbWASTJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161335AbWASTJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161338AbWASTJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:09:44 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:12425 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161335AbWASTJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:09:43 -0500
Subject: RE: My vote against eepro* removal
From: Steven Rostedt <rostedt@goodmis.org>
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323322@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F367323322@MAILIT.keba.co.at>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 14:09:04 -0500
Message-Id: <1137697744.6762.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 11:26 +0100, kus Kusche Klaus wrote:
> > From: Lee Revell
> > On Thu, 2006-01-19 at 08:19 +0100, kus Kusche Klaus wrote:
> > > Last time I tested (around 2.6.12), eepro100 worked much better 
> > > in -rt kernels w.r.t. latencies than e100:

Try the latest -rt kernel with e100 to see if it still is a delay.  You
can also run in PREEMPT_DESKTOP so that the interrupt handlers are not
threads and see if that shows up in the latency.

-- Steve


