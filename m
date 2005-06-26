Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVFZSqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVFZSqE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 14:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVFZSqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 14:46:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44165 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261546AbVFZSqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 14:46:00 -0400
Date: Sun, 26 Jun 2005 19:45:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix - add ioc3 serial driver support
Message-ID: <20050626184557.GA21428@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200506222024.j5MKO5nD023262@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506222024.j5MKO5nD023262@fsgi900.americas.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 03:24:05PM -0500, Pat Gefre wrote:
> 
> I have a patch : ftp://oss.sgi.com/projects/sn2/sn2-update/042-ioc3-support
> 
> This driver adds support for a 2 port PCI IOC3 serial card on Altix boxes.

We already have an ioc3 driver, and despite beeing in drivers/net/ it
also registers the uarts.  If the very simple serial support in there
is not enough for you please improve it instead of adding a new separate
driver.  That improvement could involve a split similar to what Brent
did for ioc4 recently.

