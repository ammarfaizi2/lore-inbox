Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUHIUQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUHIUQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUHIULM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:11:12 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:46861 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266879AbUHIUDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:03:55 -0400
Date: Mon, 9 Aug 2004 21:03:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, ehm@cris.com, grif@cs.ucr.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] QLogic ISP2x00: remove needless busyloop
Message-ID: <20040809210335.A9711@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
	ehm@cris.com, grif@cs.ucr.edu, linux-kernel@vger.kernel.org
References: <200408091252.58547.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408091252.58547.bjorn.helgaas@hp.com>; from bjorn.helgaas@hp.com on Mon, Aug 09, 2004 at 12:52:58PM -0600
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 12:52:58PM -0600, Bjorn Helgaas wrote:
> There's no need to wait for an isp2x00 to recognize a fabric if
> there's no isp2x00.  Probably nobody will notice the unnecessary
> slowdown on real hardware, but it's a significant delay on a
> simulator.

Don't use that driver.  qla2xxx is the right driver, and qlogicfc is only
still there and confuses people because davem is lazy and can shout louder
than others.

