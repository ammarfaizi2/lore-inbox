Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbTINTi0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 15:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbTINTi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 15:38:26 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:44040 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261262AbTINTiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 15:38:24 -0400
Date: Sun, 14 Sep 2003 21:38:21 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, "J.A. Magallon" <jamagallon@able.es>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: libata update posted
Message-ID: <20030914213821.A11134@pclin040.win.tue.nl>
References: <3F628DC7.3040308@pobox.com> <20030913205652.GA3478@werewolf.able.es> <20030913212849.GB21426@gtf.org> <20030914111225.A3371@pclin040.win.tue.nl> <3F64A4BD.6030906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F64A4BD.6030906@pobox.com>; from jgarzik@pobox.com on Sun, Sep 14, 2003 at 01:26:21PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 01:26:21PM -0400, Jeff Garzik wrote:

> > This shows why defkeymap.c is not generated in the kernel build
> > but distributed.
> 
> There is a difference between distributing generated files, and checking 
> generated files into a repository...  I do not advocate changing the 
> tarball, just the BK repo behind it.

So you would like to remove defkeymap.c from the bitkeeper repository.
Can you briefly explain why?
I am not a bk user so have no feeling for what one would like bk to do.

But it seems to me that if defkeymap.c is only a generated file when
no kbd headers have changed, while in the opposite case one needs a
private version of loadkeys until the next version of kbd has been
distributed, it is easier to regard it as part of the kernel source.

Andries

