Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268652AbUHLSqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268652AbUHLSqd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 14:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268650AbUHLSqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 14:46:32 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:18948 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268655AbUHLSqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 14:46:05 -0400
Date: Thu, 12 Aug 2004 19:45:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
Message-ID: <20040812194550.A3755@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <20040812173532.GD5136@suse.de> <20040812182914.GA16953@suse.de> <20040812183713.GA29664@havoc.gtf.org> <20040812184341.GA18035@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040812184341.GA18035@suse.de>; from axboe@suse.de on Thu, Aug 12, 2004 at 08:43:42PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 08:43:42PM +0200, Jens Axboe wrote:
> > If you have the struct file, can't you eliminate the inode argument?
> 
> How so?

file->f_dentry->d_inode

