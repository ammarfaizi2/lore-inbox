Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVBKRkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVBKRkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVBKReb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:34:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46237 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262302AbVBKRdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:33:08 -0500
Date: Fri, 11 Feb 2005 17:32:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device-mapper: multipath round-robin path selector.
Message-ID: <20050211173258.GA11450@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050211171644.GY10195@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211171644.GY10195@agk.surrey.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include "dm.h"
> +#include "dm-path-selector.h"
> +
> +#include <linux/slab.h>

private after public again.  Also it kinda looks to me like dm headers
pull in far too much kernel headers?

