Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUH0P5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUH0P5m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUH0PrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:47:22 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:62474 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266236AbUH0PoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:44:10 -0400
Date: Fri, 27 Aug 2004 16:44:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Latest Altix I/O code reorganization code
Message-ID: <20040827164409.A32340@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <411AAABB.8070707@sgi.com> <412F4EC9.7050003@sgi.com> <412F4FCF.6010507@sgi.com> <20040827162127.A32090@infradead.org> <412F54D4.2020905@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <412F54D4.2020905@sgi.com>; from pfg@sgi.com on Fri, Aug 27, 2004 at 10:35:48AM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 10:35:48AM -0500, Patrick Gefre wrote:
> The code was completely redone. It was not done in sections. Breaking them into
> pieces is nothing more than an academic exercise. It is not useable until all
> the code changes have been made because it would require a prom that followed these
> changes.  The point of a review was to get comments on the CONTENT of the code not
> the format of the patches.

This might be true for some parts, for others it certainy isn't.  E.g.
pci dma code still loooks remarkably similar to the old one, the klconfig
code is only stripped down a little, there's quite a few changes in the
headers that don't make much sense.

