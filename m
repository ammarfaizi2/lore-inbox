Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266066AbTGLPfW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 11:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266068AbTGLPfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 11:35:22 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:56211 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S266066AbTGLPfT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 11:35:19 -0400
Date: Sat, 12 Jul 2003 16:49:42 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Miguel Freitas <miguel@cetuc.puc-rio.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
Message-ID: <20030712154942.GB9547@mail.jlokier.co.uk>
References: <1058017391.1197.24.camel@mf> <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> With the current patch you do not need any special support if you are
> already asking for SCHED_RR policy. If you are not root you will be
> automatically downgraded to SCHED_SOFTRR ;)

Cool.  What happens if you run two SCHED_SOFTRR tasks and they both
use 50% of the CPU - will that starve all the other tasks?  Or is the
CPU usage of all SOFTRR tasks bounded collectively?

-- Jamie
