Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWCQTlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWCQTlW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 14:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWCQTlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 14:41:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27024 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751207AbWCQTlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 14:41:21 -0500
Date: Fri, 17 Mar 2006 19:41:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Eric Van Hensbergen <ericvh@hera.kernel.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net, ericvh@gmail.com
Subject: Re: [RESEND][PATCH] v9fs: print v9fs module address
Message-ID: <20060317194113.GA8848@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Eric Van Hensbergen <ericvh@hera.kernel.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
	ericvh@gmail.com
References: <200603171909.k2HJ9BiD006068@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603171909.k2HJ9BiD006068@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 07:09:14PM +0000, Eric Van Hensbergen wrote:
> Subject: [PATCH] print v9fs module address
> From: Latchesar Ionkov <lucho@ionkov.net>
> Date: 1141313037 -0500
> 
> This patch prints v9fs module address when the module is initialized. It is
> useful to have it in the logs -- if the kernel crashes the address can be
> used together with the oops print to find out the exact place (presumably in
> the v9fs code) that cause the oops.

NACK.

This just clutters the log.  The information is provided in /proc/modules
for all modules.

