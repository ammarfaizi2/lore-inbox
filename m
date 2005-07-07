Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVGGNW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVGGNW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVGGNHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:07:02 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31421 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261471AbVGGNGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:06:10 -0400
Date: Thu, 7 Jul 2005 14:06:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Victor <andrew@sanpeople.com>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] Atmel-supplied hardware headers for AT91RM9200 SoC processor
Message-ID: <20050707130607.GC28489@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org,
	Russell King <rmk@arm.linux.org.uk>
References: <1120730318.16806.75.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120730318.16806.75.camel@fuzzie.sanpeople.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 11:58:39AM +0200, Andrew Victor wrote:
> While he seems generally happy with most of the code, he has doubts
> about merging the Atmel-supplied headers and suggested I post this to
> the linux-kernel list for a wider review.
> 
> While I agree that their usage of structs/coding-style is not the
> cleanest/Linux way of doing things, re-using their headers is useful
> since:
> 1) they are supplied by the hardware manufacturer.
> 2) Atmel automatically generates them from their chip design database,
> so they should be correct.
> 3) they are used by most AT91RM9200 developers, not just those using
> Linux.

No reason to use the horror it is as-is.  Beein hardware description they
won't change ever except for additions, so just clean the mess up into
somethign nice and submit them.  You could have done so in the time you
spent arguing on linux-arm-kernel already.

