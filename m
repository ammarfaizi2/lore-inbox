Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265864AbUFDP5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265864AbUFDP5u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265851AbUFDP5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:57:45 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:1699 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S265794AbUFDP4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:56:14 -0400
Date: Fri, 4 Jun 2004 08:56:13 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jasper Spaans <jasper@vs19.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to fix timestamps in bk repo?
Message-ID: <20040604155613.GA1761@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jasper Spaans <jasper@vs19.net>, linux-kernel@vger.kernel.org
References: <20040604081926.GA24427@spaans.vs19.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604081926.GA24427@spaans.vs19.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 10:19:26AM +0200, Jasper Spaans wrote:
> Is it possible to reset the (BK-)timestamps on the following files in the
> http://linus.bkbits.net:8080/linux-2.5 repository? Somehow, they've gotten a
> timestamp which lies in the future, causing lots of warnings when I use a bk
> exported tree.

Sorry, the timestamps are part of the BK metadata and there isn't any way
to alter them after the fact.  

I'd suggest you not use the -T option to export or write a script that 
looks for timestamps in the future and fix them.

For everyone else, please keep your clocks in sync.  Whoever generated
these deltas must be running a very old version of BK (which is a license
violation by the way [whoohoo, we can now have 3 weeks of flames about
that horrible BK license that if people were obeying this wouldn't
have happened]).  Current versions of BK insist that your clock isn't
off by more than 24 hours (I suspect that this works only if you have
a net connection though, I don't remember).
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
