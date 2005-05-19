Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVESRL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVESRL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 13:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVESRL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 13:11:58 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:10245 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S261171AbVESRLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 13:11:49 -0400
To: John Clark <jclark@metricsystems.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GDB, pthreads, and kernel threads
References: <45k9a-7DD-11@gated-at.bofh.it> <45xIX-2bR-31@gated-at.bofh.it>
	<45zKO-3RV-45@gated-at.bofh.it> <428BDA56.5030502@shaw.ca>
	<428CBD63.8020704@metricsystems.com>
From: Douglas McNaught <doug@mcnaught.org>
Date: Thu, 19 May 2005 12:52:20 -0400
In-Reply-To: <428CBD63.8020704@metricsystems.com> (John Clark's message of "Thu, 19 May 2005 09:22:59 -0700")
Message-ID: <m21x839n0b.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Clark <jclark@metricsystems.com> writes:

> Also, I do believe I'm using the NPTL package for threads. Is there a
> way to absolutely tell without
> question?

If you see multiple 'ps' entries for threads (without using any
special flags to ps) you are not using NPTL.  NPTL is in 2.6 and in
some vendor 2.4 kernels, but not in kernel.org 2.4.X.  

Hope this helps!

-Doug
