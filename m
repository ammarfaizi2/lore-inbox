Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbVIVO3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbVIVO3S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 10:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbVIVO3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 10:29:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51929 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030368AbVIVO3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 10:29:16 -0400
Date: Thu, 22 Sep 2005 15:28:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Joshua Kwan <joshk@triplehelix.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org
Subject: Re: SATA suspend-to-ram patch - merge?
Message-ID: <20050922142855.GA29672@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Lord <liml@rtr.ca>, Jens Axboe <axboe@suse.de>,
	Jeff Garzik <jgarzik@pobox.com>,
	Joshua Kwan <joshk@triplehelix.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com> <20050922061849.GJ7929@suse.de> <4332ABDC.3030106@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4332ABDC.3030106@rtr.ca>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 09:04:28AM -0400, Mark Lord wrote:
> Rather than sitting around for another six months hoping the problem
> will go away (it won't), perhaps we should just update/merge Jen's
> patch as a sorely needed interim fix.
> 
> This might then prod James et al into looking more at the SCSI side of
> things, and some year we might see this get replaced with a better scheme.
> 
> This is a real problem, and an immediate solution is needed last spring.

Folks, bitching around on lkml on this won't get you far.  Send the
patch to linux-scsi again, and explain what's the current stance on the
disk synchronize cache and spindown issues.
