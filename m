Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUDSPnV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264466AbUDSPnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:43:21 -0400
Received: from zero.aec.at ([193.170.194.10]:22539 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264266AbUDSPnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:43:16 -0400
To: <stl@nuwen.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Process Creation Speed
References: <1MFUQ-1zo-3@gated-at.bofh.it> <1MGnU-1U9-19@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 19 Apr 2004 17:43:10 +0200
In-Reply-To: <1MGnU-1U9-19@gated-at.bofh.it> (Stephan T. Lavavej's message
 of "Mon, 19 Apr 2004 14:50:10 +0200")
Message-ID: <m365bwm0s1.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephan T. Lavavej" <stl@nuwen.net> writes:
>
> I changed my measurement strategy, and I now get about 110 microseconds for
> creation and termination of a do-nothing process (fork() followed by
> execve()).  Statically linking everything gave a significant speedup, which
> allowed me to reach that value.  This was on a 2.6.x kernel.  110
> microseconds is well within my "doesn't suck" range, so I'm happy - CGI will
> be fast enough for my needs, and I can always turn to FastCGI later if
> necessary.

This just means ld.so is too slow for you. Perhaps you should complain
to the glibc people about that?

-Andi

