Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268655AbUHLSsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268655AbUHLSsz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 14:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268657AbUHLSsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 14:48:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40119 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268655AbUHLSsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 14:48:15 -0400
Date: Thu, 12 Aug 2004 20:48:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
Message-ID: <20040812184800.GB18035@suse.de>
References: <1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <20040812173532.GD5136@suse.de> <20040812182914.GA16953@suse.de> <20040812183713.GA29664@havoc.gtf.org> <20040812184341.GA18035@suse.de> <20040812194550.A3755@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812194550.A3755@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12 2004, Christoph Hellwig wrote:
> On Thu, Aug 12, 2004 at 08:43:42PM +0200, Jens Axboe wrote:
> > > If you have the struct file, can't you eliminate the inode argument?
> > 
> > How so?
> 
> file->f_dentry->d_inode

Ah, ok. IMHO that should be generally done for the file_op->ioctl then.
But could easily be killed here of course.

-- 
Jens Axboe

