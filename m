Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbVIAQqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVIAQqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 12:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbVIAQqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 12:46:10 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:33764 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030241AbVIAQqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 12:46:09 -0400
Subject: Re: 2.6.13-rt3
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1125591893.7842.7.camel@localhost.localdomain>
References: <1125591893.7842.7.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 01 Sep 2005 12:46:00 -0400
Message-Id: <1125593160.5761.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-01 at 12:24 -0400, Steven Rostedt wrote:
> 
> Note: I compiled this, but I haven't run it yet. I'll run it right after
> I send this note and respond how it worked.
> 

I'm currently sending this message while running the kernel with this
patch.  But I haven't compiled with RT_DEADLOCK_DETECT. Instead I'm
recompiling with my changes to turn on all TRACE_{WARN,BUG} to be real
WARN and BUG without the deadlock detect code.  This way I can run it
without the trace_lock helping.

-- Steve


