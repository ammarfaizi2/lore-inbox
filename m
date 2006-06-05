Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750938AbWFEKy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWFEKy3 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWFEKy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:54:29 -0400
Received: from canuck.infradead.org ([205.233.218.70]:20190 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750937AbWFEKy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:54:29 -0400
Subject: Re: header cleanup and install
From: David Woodhouse <dwmw2@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060605105240.GB4400@suse.de>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <1149456793.30024.21.camel@pmac.infradead.org>
	 <20060605105240.GB4400@suse.de>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 11:54:18 +0100
Message-Id: <1149504858.30024.68.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 12:52 +0200, Jens Axboe wrote:
> I guess the color -> colour transformation is clouding the
> inclusion :-)

Heh. Well, mostly I've just _removed_ the references colo{u,}r, since
callers shouldn't be poking at it anyway in general. We have
rb_set_black() and rb_set_red() now, but even those are only really for
the rbtree code itself to be using.

-- 
dwmw2

