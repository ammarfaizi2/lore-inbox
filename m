Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbUKOXe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUKOXe1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUKOXe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:34:27 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:54225 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261651AbUKOXdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:33:53 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.10-rc2: strange behavior on dual Opteron w/ NUMA
Date: Tue, 16 Nov 2004 00:32:13 +0100
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200411152306.15606.rjw@sisk.pl> <20041115223509.GE3062@wotan.suse.de>
In-Reply-To: <20041115223509.GE3062@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411160032.13112.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 of November 2004 23:35, Andi Kleen wrote:
> > I suspect that this has been intorduced in 2.6.10-rc1-mm5, so if you have 
any 
> > ideas, please let me know.  If you need more information, please let me 
know 
> > too.
> 
> Could be the recent futex change. It seems to cause all kinds of problems.
> I would try reverting that.

You mean futex_wait-fix.patch?  Hasn't it already been identified as a buggy 
one?

RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
