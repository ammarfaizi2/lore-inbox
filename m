Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268697AbUHaQAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268697AbUHaQAg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268755AbUHaQAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:00:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44943 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268697AbUHaQAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:00:35 -0400
Message-ID: <4134A04E.3080308@redhat.com>
Date: Tue, 31 Aug 2004 11:59:10 -0400
From: Andrew Cagney <ac131313@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; NetBSD macppc; en-GB; rv:1.4.1) Gecko/20040801
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Andrew Cagney <cagney@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make single-step into signal delivery stop in handler
References: <200408310444.i7V4icex001871@magilla.sf.frob.com>
In-Reply-To: <200408310444.i7V4icex001871@magilla.sf.frob.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[wonder if I can e-mail to linux-kernel]
Just FYI, GDB's testsuite has been extended to cover this case.  The 
sigstep.exp tests pass on a kernel with this and Roland's earlier 
changes.  Ya!

Andrew

