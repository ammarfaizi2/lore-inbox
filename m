Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272157AbTGYPb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 11:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272158AbTGYPb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 11:31:56 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:7436 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272157AbTGYPbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 11:31:55 -0400
Date: Fri, 25 Jul 2003 16:46:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Willy Tarreau <willy@w.ods.org>, Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Message-ID: <20030725164649.A6557@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bernardo Innocenti <bernie@develer.com>,
	Willy Tarreau <willy@w.ods.org>, Christoph Hellwig <hch@lst.de>,
	uClinux development list <uclinux-dev@uclinux.org>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200307232046.46990.bernie@develer.com> <200307240007.15377.bernie@develer.com> <20030723222747.GF643@alpha.home.local> <200307242227.16439.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307242227.16439.bernie@develer.com>; from bernie@develer.com on Thu, Jul 24, 2003 at 10:27:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 10:27:16PM +0200, Bernardo Innocenti wrote:
> Some of the bigger 2.6 additions cannot be configured out.
> I wish sysfs and the different I/O schedulers could be removed.

Removing the I/O schedulers is pretty trivial, please come up with a
patch to make both of them optional and maybe add a trivial noop one.

Removing sysfs should also be pretty trivial but I'm not sure whether
you really want that.

