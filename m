Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267171AbUHIU1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267171AbUHIU1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUHIUXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:23:37 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:47373 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267214AbUHIUVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:21:49 -0400
Date: Mon, 9 Aug 2004 21:21:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       grif@cs.ucr.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] QLogic ISP2x00: remove needless busyloop
Message-ID: <20040809212147.A9919@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, grif@cs.ucr.edu,
	linux-kernel@vger.kernel.org
References: <200408091252.58547.bjorn.helgaas@hp.com> <20040809210335.A9711@infradead.org> <200408091419.20029.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408091419.20029.bjorn.helgaas@hp.com>; from bjorn.helgaas@hp.com on Mon, Aug 09, 2004 at 02:19:20PM -0600
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 02:19:20PM -0600, Bjorn Helgaas wrote:
> I don't use it (note the "there's no isp2x00" bit above).  But it's
> still part of ia64 defconfig (which I don't maintain), and it's easier
> to tell people "use generic_defconfig" than to tell them to remove
> CONFIG_SCSI_QLOGIC_FC by hand.

So tell David to fix up the defconfig..

> In general, I think if a driver is in the tree, it should be fair
> game for bugfixes.  In fact, I see you did the most recent one to
> qlogicfc :-)

That wasn't a bugfix, look harder.
