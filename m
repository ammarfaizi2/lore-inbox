Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUF1Lxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUF1Lxy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 07:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbUF1Lxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 07:53:54 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:14086 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264915AbUF1Lxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 07:53:50 -0400
Subject: Re: [PATCH] Staircase scheduler v7.4
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Willy Tarreau <willy@w.ods.org>
In-Reply-To: <40DFDBB2.7010800@yahoo.com.au>
References: <200406251840.46577.mbuesch@freenet.de>
	 <200406261929.35950.mbuesch@freenet.de>
	 <1088363821.1698.1.camel@teapot.felipe-alfaro.com>
	 <200406272128.57367.mbuesch@freenet.de>
	 <1088373352.1691.1.camel@teapot.felipe-alfaro.com>
	 <Pine.LNX.4.58.0406281013590.11399@kolivas.org>
	 <1088412045.1694.3.camel@teapot.felipe-alfaro.com>
	 <40DFDBB2.7010800@yahoo.com.au>
Content-Type: text/plain
Date: Mon, 28 Jun 2004 13:53:46 +0200
Message-Id: <1088423626.1699.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-28 at 18:49 +1000, Nick Piggin wrote:
> Felipe Alfaro Solana wrote:
> 
> > I have tested 2.6.7-bk10 plus from_2.6.7_to_staircase_7.7 patch and,
> > while it's definitively better than previous versions, it still feels a
> > little jerky when moving windows in X11 wrt to -mm3. Renicing makes it a
> > little bit smoother, but not as much as -mm3 without renicing.
> > 
> 
> You know, if renicing X makes it smoother, then that is a good thing
> IMO. X needs large amounts of CPU and low latency in order to get
> good interactivity, which is something the scheduler shouldn't give
> to a process unless it is told to.

But the problem here is that -ck3 with X reniced to -10 is not as smooth
as -mm3 with no renicing. That's what worries me.

