Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269213AbUINIyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269213AbUINIyX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 04:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269215AbUINIyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 04:54:23 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:53514 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269213AbUINIyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 04:54:21 -0400
Date: Tue, 14 Sep 2004 09:54:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Eric Valette <eric.valette@free.fr>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.9-rc2 : hardirq.h broken if PREEMPT enabled
Message-ID: <20040914095414.A5241@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Eric Valette <eric.valette@free.fr>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41460CC3.6000201@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41460CC3.6000201@free.fr>; from eric.valette@free.fr on Mon, Sep 13, 2004 at 11:10:27PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 11:10:27PM +0200, Eric Valette wrote:
> Christoph Hellwig  posted this patch but it was unfortunately not 
> included in linux-2.6.9-rc2. As I see oops reports with PREEMPT enabled, 
> I think people should make sure to apply this patch first.
> 
> <http://www.ussg.iu.edu/hypermail/linux/kernel/0409.1/1227.html>

this can't lead to an oops, the worst thing that could happen would
be acompile failure.  But as about half of the old <asm/hardirq.h> instances
didn't have the include either there's no driver I saw that actually
broke.

