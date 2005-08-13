Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVHMXZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVHMXZU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 19:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVHMXZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 19:25:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3524 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932403AbVHMXZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 19:25:20 -0400
Date: Sun, 14 Aug 2005 00:25:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Henrik Brix Andersen <brix@gentoo.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Watchdog device node name unification
Message-ID: <20050813232519.GA20256@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Henrik Brix Andersen <brix@gentoo.org>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <1123969015.13656.13.camel@sponge.fungus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123969015.13656.13.camel@sponge.fungus>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2005 at 11:36:55PM +0200, Henrik Brix Andersen wrote:
> Here's a patch for unifying the watchdog device node name
> to /dev/watchdog as expected by most user-space applications.
> 
> Please CC: me on replies as I am not subscribed to LKML.

Please don't.  misdevice.name is a description of the device, and doesn't
have any relation with the name of the device node.

