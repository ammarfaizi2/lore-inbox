Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268539AbUIGUj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268539AbUIGUj3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUIGU0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:26:43 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:22757 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268582AbUIGUIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 16:08:23 -0400
Date: Tue, 7 Sep 2004 16:08:11 -0400
From: Tom Vier <tmv@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040907200811.GA6595@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <4132205A.9080505@namesys.com> <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk> <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk> <41323751.5000607@namesys.com> <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org> <1093821430.8099.49.camel@lade.trondhjem.org> <Pine.LNX.4.58.0408291641070.2295@ppc970.osdl.org> <1093830135.8099.181.camel@lade.trondhjem.org> <Pine.LNX.4.58.0408291919450.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408291919450.2295@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 07:31:49PM -0700, Linus Torvalds wrote:
> Using '//' would be nice, but would break real apps. If I remember
> correctly, POSIX specifies that '//' can be special at the _beginning_ of
> a path, but in the middle, it has to act like a single '/'.

FWIW, QNX uses // for it's network fs (nfs?). //0/ means current node, //1/
first node, //2/ second, etc. I didn't even know posix said anything about
// before.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
