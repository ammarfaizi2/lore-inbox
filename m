Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVAAVK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVAAVK6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 16:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVAAVK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 16:10:58 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:59562 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261178AbVAAVKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 16:10:54 -0500
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Georg C. F. Greve" <greve@fsfeurope.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0412301418521.22893@ppc970.osdl.org>
References: <m3is6k4oeu.fsf@reason.gnu-hamburg>
	 <Pine.LNX.4.58.0412301239160.22893@ppc970.osdl.org>
	 <m3zmzvl9x1.fsf@reason.gnu-hamburg>
	 <Pine.LNX.4.58.0412301418521.22893@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104608007.14691.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 01 Jan 2005 20:06:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-30 at 22:23, Linus Torvalds wrote:
> > Meanwhile, because of the trouble, I gave Alans patch-2.6.10-ac1 a try
> > and again put ext3 on dm-crypt on raid5, and: No crash so far despite
> > moving and removing ~100 gigabytes a couple of times on to/from the
> > partition.
> 
> Goodie. Maybe Alan already knows what it's about. Alan? Any slab 
> corruption or wild pointers that you are aware of? However:

2.6.9-ac had some differign raid/md backport stuff 2.6.10-ac does not.
It has the fixes for the 1K block problem but I can't see these being
relevant.

> s
