Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbULATVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbULATVB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 14:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbULATVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 14:21:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27816 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261420AbULATU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 14:20:58 -0500
Date: Wed, 1 Dec 2004 11:20:47 -0800
Message-Id: <200412011920.iB1JKlug004542@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Joe Korty <kortyads@mindspring.com>, linux-kernel@vger.kernel.org
Subject: Re: waitid breaks telnet
In-Reply-To: Andrew Morton's message of  Tuesday, 30 November 2004 20:27:30 -0800 <20041130202730.6ceab259.akpm@osdl.org>
X-Windows: a moment of convenience, a lifetime of regret.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had no luck reproducing that, so there isn't much I can do.  The last
time someone thought the waitid change broke something random, it was the
perturbation of the compiled code vs the issue that the kernel's assembly
code doesn't follow the same calling conventions the compiler expects.
