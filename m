Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVHDV2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVHDV2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVHDV0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:26:23 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:33416 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S262709AbVHDVYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:24:49 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove suspend() calls from shutdown path
Date: Thu, 4 Aug 2005 23:30:02 +0200
User-Agent: KMail/1.8.2
References: <1123148187.30257.55.camel@gaston> <200508042251.14740.rjw@sisk.pl> <20050804135833.07a6702f.akpm@osdl.org>
In-Reply-To: <20050804135833.07a6702f.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508042330.02817.rjw@sisk.pl>
Cc: benh@kernel.crashing.org, zilvinas@gemtek.lt, torvalds@osdl.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 4 of August 2005 22:58, you wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > On Thursday, 4 of August 2005 17:20, Benjamin Herrenschmidt wrote:
> > > On Thu, 2005-08-04 at 15:16 +0300, Zilvinas Valinskas wrote:
> > > > Hello Ben, Andrew, 
> > > > 
> > > > This patch helps me if I disconnect all USB peripherals before shutting
> > > > down notebook. With connected peripherals (USB mouse, PL2303
> > > > USB<->serial converter/port) - powering off process stops right after
> > > > unmounting filesystems but before hda power off ... 
> > > > 
> > > > There is a bug report for this too:
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=4992
> > > 
> > > This is unclear.
> > > 
> > > I would expect the behaviour you report to happen _without_ this patch,
> > > that is with current git tree, and I would expect this patch to fix it
> > > by reverting to the previous 2.6.12 behaviour...
> > 
> > I had this problem on a dual-core Athlon-based machine, but the patch
> > apparently fixed it.
> > 
> 
> So are all the (three?) bugs (regressions) which you were reporting now
> fixed?

Yes.  As far as 2.6.13-rc5 (with the Ben's patch) is concerned, I have no
visible problems whatever on any of my boxes.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
