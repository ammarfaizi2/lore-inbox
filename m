Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUHGK67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUHGK67 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 06:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUHGK67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 06:58:59 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:53260 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261451AbUHGK64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 06:58:56 -0400
Date: Sat, 7 Aug 2004 11:58:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Altix I/O code reorganization
Message-ID: <20040807115854.A17606@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Pat Gefre <pfg@sgi.com>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <200408060919.20993.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408060919.20993.jbarnes@engr.sgi.com>; from jbarnes@engr.sgi.com on Fri, Aug 06, 2004 at 09:19:20AM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 09:19:20AM -0700, Jesse Barnes wrote:
> On Friday, August 6, 2004 6:18 am, Christoph Hellwig wrote:
> > Yikes, this is truely horrible.  First your patch ordering doesn't make
> > any sense, with just the first patch applied the system won't work at all.
> > Please submit a series of _small_ patches going from A to B keeping the
> > code working everywhere inbetween.
> 
> Much of this stuff is clearly interdependent (and dependent on PROM changes), 
> so I don't think that would make sense.

It's not.  E.g. hwgraph removal and dma code rework aren't related to hiding
of lots of interfaces in the firmware at all.

