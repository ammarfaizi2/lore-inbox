Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTJWKEZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 06:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTJWKEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 06:04:25 -0400
Received: from imf25aec.mail.bellsouth.net ([205.152.59.73]:18581 "EHLO
	imf25aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261743AbTJWKEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 06:04:24 -0400
Date: Thu, 23 Oct 2003 05:47:00 -0400
From: David Meybohm <dmeybohm@bellsouth.net>
To: Kurt Johnson <gorydetailz@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: exec-shield-G4 / rmap15k
Mail-Followup-To: Kurt Johnson <gorydetailz@yahoo.co.uk>,
	linux-kernel@vger.kernel.org
References: <20031021205440.34321.qmail@web86105.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031021205440.34321.qmail@web86105.mail.ukl.yahoo.com>
User-Agent: Mutt/1.3.28i
Message-Id: <20031023100423.JXGI1822.imf25aec.mail.bellsouth.net@[209.214.18.221]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 09:54:40PM +0100, Kurt Johnson wrote:

> I was wondering, has anyone out there made a port of
> exec-shield-2.4.22-G4 for 2.4.22-rmap15k ? If so, is
> it available anywhere?
> 
> I'm about to upgrade a couple of boxes, and I'd really
> love to be able to use them together, but exec-shield
> applied on top of rmap gives a couple of rejects I'm
> not sure how to resolve by hand.

If you apply exec-shield-2.4.22-G4 first you can apply rmap-15k on top
of it with rejects to only three header files in include/asm-i386:
pgtable-{2,3}level.h and page.h. If you look at the rejects, they are
exactly for changes included in exec-shield, so maybe it's ok to ignore
them.

Peace,
Dave
