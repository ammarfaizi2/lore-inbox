Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbTGMN4y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 09:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267587AbTGMN4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 09:56:53 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:34708 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S267517AbTGMN4x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 09:56:53 -0400
Date: Sun, 13 Jul 2003 15:11:21 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Miguel Freitas <miguel@cetuc.puc-rio.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
Message-ID: <20030713141121.GG19132@mail.jlokier.co.uk>
References: <1058017391.1197.24.camel@mf> <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com> <20030712154942.GB9547@mail.jlokier.co.uk> <Pine.LNX.4.55.0307120845470.4351@bigblue.dev.mcafeelabs.com> <20030712162029.GE9547@mail.jlokier.co.uk> <1058028064.1196.111.camel@mf> <20030712185157.GC10450@mail.jlokier.co.uk> <Pine.LNX.4.55.0307121806560.4720@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307121806560.4720@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> You need per-user policies to achieve fairness, the global allocation
> won't work.

Agreed that fairness is complicated.  However, a global limit is
needed because it's a big security hole to not have one.  I wonder if
a global limit can't be implemented very simply?  Users interfering
with each other's real-timeness is not half as bad as users locking up
a box.

-- Jamie
