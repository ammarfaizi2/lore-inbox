Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbUKRAnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbUKRAnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 19:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbUKRAla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 19:41:30 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:17827 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262619AbUKRAbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 19:31:05 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.10-rc2: strange behavior on dual Opteron w/ NUMA [u]
Date: Thu, 18 Nov 2004 01:29:11 +0100
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200411152306.15606.rjw@sisk.pl> <20041115223509.GE3062@wotan.suse.de> <200411160032.13112.rjw@sisk.pl>
In-Reply-To: <200411160032.13112.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411180129.11600.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 of November 2004 00:32, Rafael J. Wysocki wrote:
> On Monday 15 of November 2004 23:35, Andi Kleen wrote:
> > > I suspect that this has been intorduced in 2.6.10-rc1-mm5, so if you 
have 
> any 
> > > ideas, please let me know.  If you need more information, please let me 
> know 
> > > too.
> > 
> > Could be the recent futex change. It seems to cause all kinds of problems.
> > I would try reverting that.
> 
> You mean futex_wait-fix.patch?  Hasn't it already been identified as a buggy 
> one?

For the record: 2.6.10-rc2-mm1 does not seem to have the problem, and it has 
the futex_wait-fix.patch reverted, apparently, so I assume that this patch 
was really to blame.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
