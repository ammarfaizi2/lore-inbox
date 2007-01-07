Return-Path: <linux-kernel-owner+w=401wt.eu-S932476AbXAGKY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbXAGKY3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 05:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbXAGKY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 05:24:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38652 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932477AbXAGKY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 05:24:29 -0500
Date: Sun, 7 Jan 2007 10:24:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
Message-ID: <20070107102427.GA26849@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Amit Choudhary <amit2030@yahoo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <585769.17683.qm@web55613.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <585769.17683.qm@web55613.mail.re4.yahoo.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 12:46:50AM -0800, Amit Choudhary wrote:
> Well, I am not proposing this as a debugging aid. The idea is about correct programming, atleast
> from my view. Ideally, if you kfree(x), then you should set x to NULL. So, either programmers do
> it themselves or a ready made macro do it for them.

No, you should not.  I suspect that's the basic point you're missing.

