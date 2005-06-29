Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVF2HKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVF2HKG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVF2HKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:10:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22479 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262455AbVF2HIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:08:16 -0400
Date: Wed, 29 Jun 2005 08:08:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] freevxfs: minor cleanups
Message-ID: <20050629070814.GC16850@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi> <iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi> <20050628163114.6594e1e1.akpm@osdl.org> <1120018821.9658.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120018821.9658.4.camel@localhost>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 07:20:21AM +0300, Pekka Enberg wrote:
> The rationale for this is that since NULL is not guaranteed to be zero
> by the C standard, memset() doesn't really initialize pointers properly.

For all the machines we care it does. If a maintainer refuses to acccept
that he or she is stupid.

