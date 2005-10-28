Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbVJ1WwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbVJ1WwB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbVJ1WwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:52:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49868 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030422AbVJ1Wv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:51:59 -0400
Date: Fri, 28 Oct 2005 23:51:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: HEADS UP for QLA2100 users
Message-ID: <20051028225155.GA13958@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20051024014838.0dd491bb.akpm@osdl.org> <1130186927.6831.23.camel@localhost.localdomain> <20051024141646.6265c0da.akpm@osdl.org> <20051027152637.GC7889@plap.qlogic.org> <20051027190227.GA16211@infradead.org> <20051027215313.GB7889@plap.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051027215313.GB7889@plap.qlogic.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 02:53:13PM -0700, Andrew Vasquez wrote:
> After numerous trial and error efforts, we were able to find a
> reasonbly stable release with which the customer's configuration could
> recover and run (1.17.38 EF, quite old).
> 
> In any case, formally, QLogic has dropped *all* support for ISP2100
> cards, and thus, it's quite difficult to get any type of traction
> from the firmware folk to begin to root-cause the failures.

Sure.  We're all very happy that you invest time to help these users
anyway, and will allow us to get rid of one more unmaintained driver.

> I'm still in the process of ironing out the .bin distribution details
> locally, but perhaps once we migrate to firmware-loading exclusively
> via request_firmware(), the (small?) contigent of 2100 could use the
> EF variant I referenced above.

You know, I'm in favour of getting firmware images in the kernel image,
but what's the problem of simply downgrading the 2100 firmware until
we get rid of the builtin firmware for all qla2xxx variants?

> Could I get another informal count of 2100 users who are still having
> problems with qla2xxx?

