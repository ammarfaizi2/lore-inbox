Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750807AbWFEI7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWFEI7V (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWFEI7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:59:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9619 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750807AbWFEI7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:59:21 -0400
Date: Mon, 5 Jun 2006 09:59:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: merging new drivers (was Re: 2.6.18 -mm merge plans)
Message-ID: <20060605085918.GB26766@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
	linux-kernel@vger.kernel.org
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605013223.GD17361@havoc.gtf.org> <20060604184711.0a328d18.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604184711.0a328d18.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 06:47:11PM -0700, Andrew Morton wrote:
> Yes, I agree.  As long as we reasonably think that a piece of code *will*
> become acceptable within a reasonable amount of time then going early is
> safe.


Definitly not the case for areca.  The only progress at all is where people
like Arjan, Randy or me did very intensive babysitting.  And it's still far
from beeing there.

And especially in scsi land I'm absolutely against putting in more substandard
drivers.  The subsystem is still badly plagued from lots of old drivers that
aren't up to any standards, and we need to decrease the maintaince load due
to odd drivers not increase it even further.
