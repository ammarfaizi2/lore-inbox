Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVCYTHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVCYTHi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 14:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVCYTHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 14:07:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55958 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261746AbVCYTHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 14:07:35 -0500
Date: Fri, 25 Mar 2005 19:07:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Bottomley <jejb@steeleye.com>
Cc: Christoph Hellwig <hch@infradead.org>, Bruno Cornec <Bruno.Cornec@hp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, tvignaud@mandrakesoft.com
Subject: Re: megaraid driver (proposed patch)
Message-ID: <20050325190732.GA15497@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Bottomley <jejb@steeleye.com>,
	Bruno Cornec <Bruno.Cornec@hp.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	tvignaud@mandrakesoft.com
References: <20050325182252.GA4268@morley.grenoble.hp.com> <1111775992.5692.25.camel@mulgrave> <20050325184718.GA15215@infradead.org> <1111777477.5692.29.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111777477.5692.29.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 01:04:37PM -0600, James Bottomley wrote:
> You get a kernel with two drivers trying to claim some of the same set
> of cards.  The winner will be the driver that gets its init routines
> called first, but this isn't a desirable outcome.
> 
> I wouldn't object to a patch that allows both *modules* to be built,
> which is all I think the distros are after.

The new megaraid driver doesn't support old hardware.  Maybe we should
drop the overlapping pci ids from the old driver?

