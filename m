Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267537AbUG2XJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267537AbUG2XJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 19:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUG2XIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 19:08:20 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:42459 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S267521AbUG2XEK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 19:04:10 -0400
Subject: Re: [Patch] Per kthread freezer flags
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091141832.2114.2.camel@teapot.felipe-alfaro.com>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040728142026.79860177.akpm@osdl.org>
	 <1091053822.1844.4.camel@teapot.felipe-alfaro.com>
	 <1091054194.8867.26.camel@laptop.cunninghams>
	 <1091056916.1844.14.camel@teapot.felipe-alfaro.com>
	 <1091061983.8867.95.camel@laptop.cunninghams>
	 <1091141832.2114.2.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1091142091.2703.54.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 30 Jul 2004 09:01:31 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-07-30 at 08:57, Felipe Alfaro Solana wrote:
> Well, I've tried the kthread freezer patch against 2.6.8-rc2-mm1 and it
> works fine. However, with kthread freezer applied, suspending and
> resuming is much slower (around 5 seconds slower). Thus, I guess all my
> problems must be related to some specific patch I'm applying against the
> current -bk tree.

Okay. That might be due to the treatment of ksoftirqd, which Pavel and I
have agreed needs changing.

> I'll keep investigating this issue, but I think voluntary-preempt might
> have some strange interactions with these kthread changes.

Me too, when I get a chance. I'm running rc2-mm1 now, and it seems okay.
Especially since I turned off USB 2 support in the BIOS :>

Nigel

