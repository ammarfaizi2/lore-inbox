Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbTEEGqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 02:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTEEGqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 02:46:43 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:38584
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S261971AbTEEGqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 02:46:42 -0400
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vsyscall unwind information
References: <20030502004014$08e2@gated-at.bofh.it>
	<20030503210015$292c@gated-at.bofh.it>
	<20030504063010$279f@gated-at.bofh.it>
From: David Mosberger-Tang <David.Mosberger@acm.org>
Date: 04 May 2003 23:49:31 -0700
In-Reply-To: <20030504063010$279f@gated-at.bofh.it>
Message-ID: <ugade16g78.fsf@panda.mostang.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 04 May 2003 08:30:10 +0200, Richard Henderson <rth@twiddle.net> said:

  Richard> Also adds unwind info for the sigreturn entry points.  This
  Richard> can be used instead of special-case hacks currently in
  Richard> libgcc and gdb, and by extension allows the kernel to
  Richard> change these entry points without breaking userland.

Is there a marker or some other way to identify the sigreturn as such?
If not, could one be added?

	--david
