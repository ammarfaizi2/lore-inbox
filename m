Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268598AbUHLQEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268598AbUHLQEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 12:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268599AbUHLQEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 12:04:10 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:12548 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268598AbUHLQEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 12:04:07 -0400
Date: Thu, 12 Aug 2004 17:04:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove whitespace from ALI15x3 IDE driver name
Message-ID: <20040812170400.A2448@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
References: <1092336877.7433.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1092336877.7433.1.camel@localhost>; from penberg@cs.helsinki.fi on Thu, Aug 12, 2004 at 06:54:38PM +0000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 06:54:38PM +0000, Pekka Enberg wrote:
> This patch removes whitespace from ALI15x3 IDE driver name that appears in the
> sysfs directory. It is against 2.6.7.

You jnow that this breaks every tool that knew of the names so far?  E.g.
Debian mkinitrd (now has a patch to deal with both the whitespace and
non-whitespace variants) and probably quite a few installers out there.

