Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272277AbTHDWCQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272278AbTHDWCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:02:16 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:45062 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272277AbTHDWCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:02:14 -0400
Date: Mon, 4 Aug 2003 23:02:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chip Salzenberg <chip@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.22pre10: fs/aio.c should include <linux/poll.h>
Message-ID: <20030804230213.B6566@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chip Salzenberg <chip@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030804170900.GA8221@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030804170900.GA8221@perlsupport.com>; from chip@pobox.com on Mon, Aug 04, 2003 at 01:09:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 01:09:00PM -0400, Chip Salzenberg wrote:
> Since fs/aio.c calls async_poll(), it should include <linux/poll.h> to
> get its declaration.

There is no fs/aio.c in 2.4.22-pre10.

