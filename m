Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTFYAeY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 20:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTFYAeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 20:34:24 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:19937 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S263487AbTFYAeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 20:34:19 -0400
Date: Tue, 24 Jun 2003 20:48:28 -0400
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21: kernel BUG at ide-iops.c:1262!
Message-ID: <20030624204828.I30001@newbox.localdomain>
References: <1056493150.2840.17.camel@ori.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1056493150.2840.17.camel@ori.thedillows.org>; from dave@thedillows.org on Tue, Jun 24, 2003 at 06:19:10PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Dillow on Tue 24/06 18:19 -0400:
> I've found a completely repeatable BUG/panic in 2.4.21
> (final). The kernel BUGS and then panics in an interrupt
> while beginning to burn a DVD+R. I get the following in
> the logs, then the BUG/panic decoded at the end of this
> message:

There were recent threads about this, and a Bugzilla bug 829
I think.  Try killing magicdev.
