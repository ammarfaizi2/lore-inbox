Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275399AbTHNRbp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273389AbTHNRbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:31:45 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:20744 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S275423AbTHNRaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:30:25 -0400
Date: Thu, 14 Aug 2003 18:30:24 +0100
From: John Levon <levon@movementarian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
Message-ID: <20030814173024.GA42066@compsoc.man.ac.uk>
References: <20030814165512.GA36329@compsoc.man.ac.uk> <Pine.LNX.4.44.0308141011030.8148-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308141011030.8148-100000@home.osdl.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19nLvc-00029o-Vt*W1eBHKLvL0w*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 10:14:37AM -0700, Linus Torvalds wrote:

> Why not just fix the oprofile interfaces to contain that information? You 
> already have to export CPU type, buffer size etc..

I'll quite happily do that. I'd assumed it was also rejected for bloat
reasons based on your previous objections that it was/should be entirely
a userspace issue.

If you'll take /dev/oprofile/pointer_size now, then I'm more than happy
to drop the kcore sniffing (and I don't have the a.out problem any more)

regards
john

-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
