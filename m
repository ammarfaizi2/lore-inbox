Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUJRSep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUJRSep (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267306AbUJRSeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:34:04 -0400
Received: from peabody.ximian.com ([130.57.169.10]:5305 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267304AbUJRScr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:32:47 -0400
Subject: Re: [patch] Voluntary Preempt additions
From: Robert Love <rml@novell.com>
To: dwalker@mvista.com
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <1098121769.26597.5.camel@dhcp153.mvista.com>
References: <1098121769.26597.5.camel@dhcp153.mvista.com>
Content-Type: text/plain
Date: Mon, 18 Oct 2004 14:30:52 -0400
Message-Id: <1098124252.1597.8.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 10:49 -0700, Daniel Walker wrote:
                                                                                   
> - Modified latency tracer to trace non-preemptable mutex locking , in
> /proc/lock_trace

Why?

It is a bug to have preemption disabled when entering non-atomic
(schedulable) code, and a stack trace is dumped if that happens.

Isn't that sufficient?

	Robert Love


