Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUA2URV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 15:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266408AbUA2URV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 15:17:21 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:43277 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266242AbUA2URQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 15:17:16 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lindent fixed to match reality
References: <20040129193727.GJ21888@waste.org>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 29 Jan 2004 12:17:13 -0800
In-Reply-To: <20040129193727.GJ21888@waste.org>
Message-ID: <52isiucxx2.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 29 Jan 2004 20:17:15.0274 (UTC) FILETIME=[E2ED66A0:01C3E6A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Matt> b) (no -bs) "sizeof(foo)" rather than "sizeof (foo)"
    Matt> c) (-ncs) "(void *)foo" rather than "(void *) foo"

I disagree about both b) and c).  In particular, you would always
write "sizeof variable" (since "sizeofvariable" wouldn't even compile)
and there's no sense in fooling people into thinking sizeof is a
function.  Similarly I like the space after the () operator (although
you could argue we don't put space after a unary - operator).

 - Roland
