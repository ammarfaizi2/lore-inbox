Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbVLQNQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbVLQNQQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 08:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbVLQNQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 08:16:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36762 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932576AbVLQNQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 08:16:15 -0500
Date: Sat, 17 Dec 2005 13:16:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 00/13]  [RFC] IB: PathScale InfiniPath driver
Message-ID: <20051217131614.GB13043@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org
References: <20051031150618.627779f1.akpm@osdl.org> <200512161548.jRuyTS0HPMLd7V81@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512161548.jRuyTS0HPMLd7V81@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 03:48:54PM -0800, Roland Dreier wrote:
> having sysctls that set values also settable through module parameters
> under /sys/module, code inside #ifndef __KERNEL__ so include files can
> be shared with other PathScale code, code in ipath_i2c.c that might be
> simplified by using drivers/i2c, etc.  I'd like to try to get a sense
> of whether I'm being too picky or whether PathScale really does need
> to fix these up before the driver is merged.

Yes, please fix this stuff before.  The current driver looks like a horrible
mess.

Is there some political plot going where pathscale folks are forcing you to
send this out in this scheme?  Otherwise I couldn't explain the code quality
magnitudes lower than normally expected from your merges.
