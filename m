Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268530AbUH3QKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268530AbUH3QKU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 12:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268533AbUH3QKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 12:10:20 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:25092 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268530AbUH3QKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 12:10:14 -0400
Date: Mon, 30 Aug 2004 17:10:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Halcrow <mahalcro@us.ibm.com>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, mike@halcrow.us
Subject: Re: [PATCH] BSD Secure Levels LSM (1/3)
Message-ID: <20040830171002.A10691@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Halcrow <mahalcro@us.ibm.com>, chrisw@osdl.org,
	linux-kernel@vger.kernel.org, mike@halcrow.us
References: <20040830143547.GA9980@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040830143547.GA9980@halcrow.us>; from mike@halcrow.us on Mon, Aug 30, 2004 at 09:35:47AM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + * Potential future enhancements:
> + *  - Export a kill_seclvl function to the rest of the kernel to allow
> + *    other modules to disable or change the seclvl (i.e., rootplug
> + *    could reduce the seclvl).

Please removed all that downgrading stuff.  The whole point of the BSD
surelevels is that they can't be turned back.

