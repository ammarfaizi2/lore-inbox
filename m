Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUGHNjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUGHNjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUGHNjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:39:40 -0400
Received: from [213.146.154.40] ([213.146.154.40]:9628 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262138AbUGHNjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:39:35 -0400
Date: Thu, 8 Jul 2004 14:39:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Erik Rigtorp <erik@rigtorp.com>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] swsusp bootsplash support
Message-ID: <20040708133934.GA10997@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Erik Rigtorp <erik@rigtorp.com>, linux-kernel@vger.kernel.org,
	pavel@ucw.cz
References: <20040708110549.GB9919@linux.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708110549.GB9919@linux.nu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 01:05:49PM +0200, Erik Rigtorp wrote:
> This patch adds support for bootsplash to swsusp. The code interfacing to
> bootsplash needs some more work, currently it's more or less ripped from
> swsusp2. Some more code could probably be moved into console.c instead.

CONFIG_BOOTSPALSH (foruntatley) isn't in mainline, so while you're of course
free to keep this patch around it has no business at all in mainline.

