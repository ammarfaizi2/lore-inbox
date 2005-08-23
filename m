Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVHWJ5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVHWJ5p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 05:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVHWJ5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 05:57:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17582 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932117AbVHWJ5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 05:57:45 -0400
Date: Tue, 23 Aug 2005 10:57:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Brent Casavant <bcasavan@sgi.com>, pavel@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] external interrupts
Message-ID: <20050823095741.GB4425@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Brent Casavant <bcasavan@sgi.com>,
	pavel@suse.cz, linux-kernel@vger.kernel.org
References: <20050819160716.U87000@chenjesu.americas.sgi.com> <20050820222159.GP516@openzaurus.ucw.cz> <20050822155852.N325@chenjesu.americas.sgi.com> <20050822144330.791ba7b3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822144330.791ba7b3.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 02:43:30PM -0700, Andrew Morton wrote:
> > Laughter was not wholly unexpected, though I wasn't joking.  I'm trying
> > to be realistic about the lifetime of any given hardware, and IOC4 is
> > several years old at this point.  Couple that with a sincere desire to
> > preserve application source compatability when (not if) new hardware
> > appears, and an abstraction layer seemed to be a logical choice.  I'm
> > more than happy to discuss problems in the abstraction layer's interface
> > and make appropriate changes -- I'm nothing if not obliging.
> 
> Having an abstraction layer for a single client driver does seem a bit
> pointless.  It would become more pointful if other client drivers were to
> pop up.

The Octane port will hopefully soon support external inteerupts on the
ioc3, so this does make sense.

