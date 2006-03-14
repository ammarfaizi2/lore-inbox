Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751909AbWCNKcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbWCNKcY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbWCNKcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:32:24 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:54659 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751909AbWCNKcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:32:22 -0500
Date: Tue, 14 Mar 2006 05:26:52 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: What is ptrace flag PT_TRACESYSGOOD for?
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200603140531_MC3-1-BAA0-B3C3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to document PTRACE_SETOPTIONS and I can't figure out what
the option PTRACE_O_TRACESYSGOOD is used for.  Google is no help;
I can't find an explanation for _why_ it's there.  All I can see is that
it causes ptrace() to deliver syscall stops with SIGTRAP | 0x80
instead of just SIGTRAP and it can be used with PTRACE_SYSEMU.


-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

