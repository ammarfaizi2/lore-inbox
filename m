Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbUJYMgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbUJYMgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbUJYMgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:36:41 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:50188 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261782AbUJYMg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:36:27 -0400
Date: Mon, 25 Oct 2004 13:36:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miles Bader <miles@gnu.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: generic hardirq code in 2.6.10-rc1
Message-ID: <20041025123624.GA32463@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miles Bader <miles@gnu.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arch@vger.kernel.org
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041024155443.GA25013@infradead.org> <buod5z7jpws.fsf@mctpc71.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buod5z7jpws.fsf@mctpc71.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 03:02:59PM +0900, Miles Bader wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> > Btw, it would be nice if all architectures that have more or less
> > a copy of the i386 irq.c could switch to the generic code.
> >
> > That would be:  alpha,ia64, m32r, mips, sh, sh64, um, v850
> 
> Er, yeah, hold on (speaking for v850, I generally only ever look at real
> releases and try to update for the next one).

It's not urgent anyway - the old code continues to work, it'd just be nicer
if as many as possible architectures used the common code.

