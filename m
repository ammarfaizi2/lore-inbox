Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265824AbUEZVr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265824AbUEZVr5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 17:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUEZVr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 17:47:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:18064 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265824AbUEZVrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 17:47:45 -0400
Subject: Re: [PATCH] ppc32 implementation of ptep_set_access_flags
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405260756590.1929@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>
	 <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	 <1085371988.15281.38.camel@gaston>
	 <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	 <1085373839.14969.42.camel@gaston>
	 <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
	 <20040525034326.GT29378@dualathlon.random>
	 <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
	 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org>
	 <20040525153501.GA19465@foobazco.org>
	 <Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org>
	 <20040525102547.35207879.davem@redhat.com>
	 <Pine.LNX.4.58.0405251034040.9951@ppc970.osdl.org>
	 <20040525105442.2ebdc355.davem@redhat.com>
	 <Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org>
	 <1085521251.24948.127.camel@gaston>
	 <Pine.LNX.4.58.0405251452590.9951@ppc970.osdl.org>
	 <Pine.LNX.4.58.0405251455320.9951@ppc970.osdl.org>
	 <1085522860.15315.133.camel@gaston>
	 <Pine.LNX.4.58.0405251514200.9951@ppc970.osdl.org>
	 <1085530867.14969.143.camel@gaston>
	 <Pine.LNX.4.58.0405251749500.9951@ppc970.osdl.org>
	 <1085541906.14969.412.camel@gaston>
	 <Pine.LNX.4.58.0405252031270.15534@ppc970.osdl.org>
	 <1085546780.5584.19.camel@gaston>
	 <Pine.LNX.4.58.0405252151100.15534@ppc970.osdl.org>
	 <1085551152.6320.38.camel@gaston> <1085554527.7835.59.camel@gaston>
	 <1085555491.7835.61.camel@gaston>
	 <Pine.LNX.4.58.0405260756590.1929@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1085607795.5584.67.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 27 May 2004 07:43:16 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-27 at 01:22, Linus Torvalds wrote:

> The "new" rules (well, they aren't new, but now they are explicitly
> spelled out) for this thing are:

Looks fine. I'll dbl check everything on the g5 once I reach the office

Ben.


