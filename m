Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUJRRtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUJRRtd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 13:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUJRRtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 13:49:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60145 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266561AbUJRRtb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 13:49:31 -0400
Subject: [patch] Voluntary Preempt additions
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1098121769.26597.5.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 18 Oct 2004 10:49:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is in addition to voluntary preempt U5 . So, first apply up to
Voluntary Preempt U4 , then apply this patch. I'll release for U5 as
soon as it's formally released. 

We are releasing the following new features,
                                                                                      
- Architecture independent mutex with priority inheritance. Note, we 
have only tested this in x86.
                                                                                      
- Modified latency tracer to trace non-preemptable mutex locking , in
/proc/lock_trace
                                                                                      
- Added two new locking functions _mutex_lock_cpu and _mutex_unlock_cpu.


Get the patch at,

ftp://source.mvista.com/pub/realtime/Linux-2.6.9_rc4-mm1-U4.patch


Daniel Walker

