Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267640AbUHELWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267640AbUHELWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267646AbUHELWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:22:11 -0400
Received: from zork.zork.net ([64.81.246.102]:12522 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S267640AbUHELUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:20:03 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1
References: <20040805031918.08790a82.akpm@osdl.org>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
 linux-kernel@vger.kernel.org
Date: Thu, 05 Aug 2004 12:20:02 +0100
In-Reply-To: <20040805031918.08790a82.akpm@osdl.org> (Andrew Morton's
 message
	of "Thu, 5 Aug 2004 03:19:18 -0700")
Message-ID: <6u4qnhzva5.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Built successfully with SMP=y, but with SMP=n I got the following:

  CC      kernel/sched.o
kernel/sched.c: In function `show_schedstat':
kernel/sched.c:372: error: structure has no member named `sd'
kernel/sched.c:372: error: dereferencing pointer to incomplete type
kernel/sched.c:375: error: dereferencing pointer to incomplete type
kernel/sched.c:380: error: dereferencing pointer to incomplete type
kernel/sched.c:381: error: dereferencing pointer to incomplete type
kernel/sched.c:382: error: dereferencing pointer to incomplete type
kernel/sched.c:383: error: dereferencing pointer to incomplete type
kernel/sched.c:384: error: dereferencing pointer to incomplete type
kernel/sched.c:387: error: dereferencing pointer to incomplete type
kernel/sched.c:387: error: dereferencing pointer to incomplete type
kernel/sched.c:388: error: dereferencing pointer to incomplete type
kernel/sched.c:388: error: dereferencing pointer to incomplete type
make[1]: *** [kernel/sched.o] Error 1
make: *** [kernel] Error 2

