Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTLHTe1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbTLHTe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:34:27 -0500
Received: from ns.transas.com ([193.125.200.2]:8974 "EHLO
	harvester.transas.com") by vger.kernel.org with ESMTP
	id S261660AbTLHTeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:34:21 -0500
Message-ID: <2E74F312D6980D459F3A05492BA40F8D0391B0F0@clue.transas.com>
From: Andrew Volkov <Andrew.Volkov@transas.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE: PROBLEM: possible proceses leak
Date: Mon, 8 Dec 2003 22:34:13 +0300 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="koi8-r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, really magic, sorry for troubles.

Andrey

> 
> On Mon, 8 Dec 2003, William Lee Irwin III wrote:
> >> Heh, no wonder everyone wants to get rid of the things.
> 
> On Mon, Dec 08, 2003 at 11:09:41AM -0800, Linus Torvalds wrote:
> > No, they are all correct. No bug here, move along folks, 
> nothing to see..
> > 		Linus
> 
> Looks like I missed that bit of preempt magic the first time around
> the need_resched: path in entry.S. Easy enough to drop this one.
> 
> 
> -- wli
> 
