Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUGLQem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUGLQem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 12:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266887AbUGLQem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 12:34:42 -0400
Received: from [213.146.154.40] ([213.146.154.40]:11473 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266885AbUGLQek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 12:34:40 -0400
Date: Mon, 12 Jul 2004 17:34:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
Message-ID: <20040712163439.GA27041@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Peter Osterlund <petero2@telia.com>,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@osdl.org>
References: <m2lli36ec9.fsf@telia.com> <20040710232714.GA21633@infradead.org> <m2r7rjpd24.fsf@telia.com> <200407121825.47889.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407121825.47889.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Merge pktcdvd completely into the cdrom subsystem so the existing cdrom
>   device node passes everything down to pktcdvd if an RW medium is mounted
>   writable.

Well, we had that already earlier on.  I'd prefer that and it seems Jens, too.
But it's a lot of work, and definitly not 2.6 material.

