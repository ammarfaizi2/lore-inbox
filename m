Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTE2QGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTE2QGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:06:14 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:9740 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262366AbTE2QGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:06:11 -0400
Date: Thu, 29 May 2003 17:19:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup
Message-ID: <20030529171927.A21828@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	chas williams <chas@cmf.nrl.navy.mil>, davem@redhat.com,
	linux-kernel@vger.kernel.org
References: <200305291609.h4TG9rx01188@relax.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305291609.h4TG9rx01188@relax.cmf.nrl.navy.mil>; from chas@cmf.nrl.navy.mil on Thu, May 29, 2003 at 12:09:54PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 12:09:54PM -0400, chas williams wrote:
> the three following changesets attempt to bring the he atm
> driver into conformance with the accepted linux coding style,
> fix some chattiness the irq handler, and address the stack
> usage issue in he_init_cs_block_rcm().

btw, could you also remove the BUS_INT_WAR hacks?  There shouldn't
be anz SHUB1.0 Altix systems around anymore..

