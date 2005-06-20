Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVFTKp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVFTKp4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 06:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVFTKpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 06:45:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2777 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261165AbVFTKpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 06:45:49 -0400
Date: Mon, 20 Jun 2005 11:45:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Q: qla23xxx and lpfc (Was: Re: [GIT PATCH] SCSI updates for 2.6.12)
Message-ID: <20050620104544.GA28488@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1119103586.4984.5.camel@mulgrave> <20050618141636.GA4112@infradead.org> <20050618174558.GX9153@shell0.pdx.osdl.net> <1119260140.6099.0.camel@mulgrave> <Pine.BSO.4.62.0506201217410.19853@rudy.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.62.0506201217410.19853@rudy.mif.pg.gda.pl>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 12:33:49PM +0200, Tomasz K?oczko wrote:
> Included in vanilla 2.6.12 qla23xxx 8.00.02b5 is for me unuseable (fails 
> on scaning luns and oopses on array controler reset) on x86_64 with
> qla2300 and for me works only version 8.01.00b2.
> Is it will be possible include this version in official tree ?

As said above a bad patch from Qlogic went in and Linus didn't pull the
release critical fixes tree before release.  It'll be fixed in 2.6.12.1.
8.01.00b2 is full of crap and despite the higher version number actually
a regression vs the kernel driver in various aspects.

> Also is it will be possible include Emulex lpfc driver to official tree ?

See drivers/scsi/lpfc/

