Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVH2LNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVH2LNp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 07:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVH2LNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 07:13:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5257 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751050AbVH2LNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 07:13:44 -0400
Date: Mon, 29 Aug 2005 12:13:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Henrik Brix Andersen <brix@gentoo.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Watchdog device node name unification
Message-ID: <20050829111342.GA2861@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Henrik Brix Andersen <brix@gentoo.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <1123969015.13656.13.camel@sponge.fungus> <1123970037.13656.16.camel@sponge.fungus> <Pine.LNX.4.58.0508131520520.3553@g5.osdl.org> <1125311556.20765.65.camel@sponge.fungus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125311556.20765.65.camel@sponge.fungus>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 12:32:35PM +0200, Henrik Brix Andersen wrote:
> On Sat, 2005-08-13 at 15:21 -0700, Linus Torvalds wrote:
> > Doesn't seem to be serious enough to be worth it at this late stage in the 
> > 2.6.13 game. Can you re-send after I do a release?
> 
> Resending as requested:
> 
> Here's a patch for unifying the watchdog device node name
> to /dev/watchdog as expected by most user-space applications.
> 
> Please CC: me on replies as I am not subscribed to LKML.

Again, please fix the miscdev code to no pass .name to the dev routines.
The miscdev name should be a description and has nothing to do with a
device node name.

