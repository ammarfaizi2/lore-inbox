Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWGWTpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWGWTpD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 15:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWGWTpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 15:45:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45030 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751279AbWGWTpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 15:45:00 -0400
Date: Sun, 23 Jul 2006 20:44:03 +0100
From: hch <hch@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jeff@garzik.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Ed Lin <ed.lin@promise.com>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       hch <hch@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, promise_linux <promise_linux@promise.com>
Subject: Re: [PATCH] Promise 'stex' driver
Message-ID: <20060723194403.GA25789@infradead.org>
Mail-Followup-To: hch <hch@infradead.org>, Jens Axboe <axboe@suse.de>,
	Jeff Garzik <jeff@garzik.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Ed Lin <ed.lin@promise.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
	promise_linux <promise_linux@promise.com>
References: <NONAMEBMcvsq9IcVux1000001f9@nonameb.ptu.promise.com> <44BFF539.4000700@garzik.org> <1153439728.4754.19.camel@mulgrave> <44C01CD7.4030308@garzik.org> <20060721010724.GB24176@suse.de> <44C02D1E.4090206@garzik.org> <20060721013822.GA25504@suse.de> <44C037B3.4080707@garzik.org> <20060721023647.GA29220@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060721023647.GA29220@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2006 at 04:36:47AM +0200, Jens Axboe wrote:
> If I thought that it would ever be updated to use block tagging, I would
> not care at all. The motivation to add it from the Promise end would be
> zero, as it doesn't really bring any immediate improvements for them. So
> it would have to be done by someone else, which means me or you. I don't
> have the hardware to actually test it, so unless you do and would want
> to do it, chances are looking slim :-)
> 
> It's a bit of a chicken and egg problem, unfortunately. The block layer
> tagging _should_ be _the_ way to do it, and as such could be labelled a
> requirement. I know that's a bit harsh for the Promise folks, but
> unfortunately someone has to pay the price...

Exactly.  And the only way to get folks to use shared infrastructure is to
force new users to use it.  Helped for FC, helps for filesystem infrastructure.
It's a community model, everyone has to suffer a little upfront so that the
whole community benefits in the end.
