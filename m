Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUGJX1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUGJX1S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 19:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUGJX1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 19:27:18 -0400
Received: from [213.146.154.40] ([213.146.154.40]:7358 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266459AbUGJX1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 19:27:15 -0400
Date: Sun, 11 Jul 2004 00:27:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
Message-ID: <20040710232714.GA21633@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Peter Osterlund <petero2@telia.com>,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@osdl.org>
References: <m2lli36ec9.fsf@telia.com> <m2llhz5o4o.fsf@telia.com> <m2fz875nkv.fsf@telia.com> <200407110120.47256.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407110120.47256.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 01:20:45AM +0200, Arnd Bergmann wrote:
> These are actually incorrect definitions since the ioctl argument is
> not a pointer to unsigned int but instead just an int. However, that's
> too late to fix without breaking the existing tools.

The tools need to change anyway to get away from the broken behaviour to
issue in ioctl on the actual block device to bind it..

