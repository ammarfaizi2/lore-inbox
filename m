Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWJEWMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWJEWMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWJEWMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:12:49 -0400
Received: from mail.gmx.de ([213.165.64.20]:55456 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932336AbWJEWMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:12:48 -0400
X-Authenticated: #20450766
Date: Fri, 6 Oct 2006 00:12:58 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jeff Garzik <jeff@garzik.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] scsi updates for post 2.6.18
In-Reply-To: <45256728.2060004@garzik.org>
Message-ID: <Pine.LNX.4.60.0610060011320.14466@poirot.grange>
References: <1159995678.3437.80.camel@mulgrave.il.steeleye.com>
 <Pine.LNX.4.60.0610052104330.6619@poirot.grange> <45255A02.2010308@garzik.org>
 <Pine.LNX.4.60.0610052129020.6619@poirot.grange> <45256728.2060004@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, Jeff Garzik wrote:

> Guennadi Liakhovetski wrote:
> > Sure, it WOULD be nice, but I don't know how. The "don't know" refers to the
> > case 16MB block size, my tape supports only 16MB - 1 byte (according to st
> > report). Is there a way to test various block sizes with CDs / hard-disks /
> > ZIP / scanners? Would something with sg_dd work? Looks like it must be only
> > sector size. Can I low-level format a disk with 16M sector?:-)
> > 
> > Another possibility is to limit the block size at 8MB - I can test that.
> 
> I would say, increase it to whatever the max is you can test...

Ok, tested with 8MB, an updated patch submitted.

Thanks for the suggestion
Guennadi
---
Guennadi Liakhovetski
