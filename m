Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVIGPEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVIGPEl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 11:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVIGPEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 11:04:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12202 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932157AbVIGPEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 11:04:40 -0400
Date: Wed, 7 Sep 2005 16:04:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Yasushi SHOJI <yashi@atmark-techno.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
Subject: Re: [PATCH] add romfs_get_size()
Message-ID: <20050907150439.GA6646@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Yasushi SHOJI <yashi@atmark-techno.com>,
	linux-kernel@vger.kernel.org,
	Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
References: <87k6htt0tg.wl@mail2.atmark-techno.com> <20050907142604.GA5822@infradead.org> <87irxdt0dz.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87irxdt0dz.wl@mail2.atmark-techno.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 11:31:36PM +0900, Yasushi SHOJI wrote:
> > On Wed, Sep 07, 2005 at 11:22:19PM +0900, Yasushi SHOJI wrote:
> > > Many embedded linux products have been using romfs and it's still
> > > growing.  most, if not all, of them implement thier own way to check
> > > its romfs size.
> > > 
> > > this patch provides this commonly used function.
> > 
> > Used where.  Please come back as soon as you have a caller in-tree
> > which makes sense..
> 
> i don't know this one make sense but the biggest user is uclinux mtd
> map. in uclinux_mtd_init():

I don't quite see the corelation.  Anyway, please submit a patch series
that converts whatever wrong variant to the new one, describing each
patch in detail, and adding proper ROMFS depencies to the places using
it.
