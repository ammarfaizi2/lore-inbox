Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263708AbUDQICW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 04:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbUDQICW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 04:02:22 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:24075 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263708AbUDQICU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 04:02:20 -0400
Date: Sat, 17 Apr 2004 10:02:15 +0200
From: Willy Tarreau <w@w.ods.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] e1000 fails on 2.4.26+bk with CONFIG_SMP=y
Message-ID: <20040417080215.GE596@alpha.home.local>
References: <20040416224422.GA19095@tsunami.ccur.com> <20040417072455.GD596@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417072455.GD596@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 09:24:56AM +0200, Willy Tarreau wrote:
> On Fri, Apr 16, 2004 at 06:44:22PM -0400, Joe Korty wrote:
> > The e1000 driver fails to operate an Intel PRO/1000 MT Quad Port Server
> > Adaptor under the latest 2.4.26+bk with CONFIG_SMP=y.  It works fine
> > when CONFIG_SMP=n.
> 
> Did you enable APIC in UP mode, and did you try with an SMP kernel booted
> with the 'nosmp' option ? Have you tried with plain 2.4.26 too ? There were
> e1000 changes in latest bk.

Just FYI, at least the 544 (single port chip) works fine on a dual athlon in
2.4.26+bk.

Cheers,
Willy

