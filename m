Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbTIPS0I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 14:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbTIPS0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 14:26:08 -0400
Received: from ns2.eclipse.net.uk ([212.104.129.133]:26895 "EHLO
	smtp2.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S261806AbTIPS0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 14:26:06 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
Date: Tue, 16 Sep 2003 19:26:02 +0100
User-Agent: KMail/1.5.3
References: <20030910114346.025fdb59.akpm@osdl.org> <200309160134.28169.ianh@iahastie.local.net> <20030916092040.GB930@suse.de>
In-Reply-To: <20030916092040.GB930@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309161926.04549.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 Sep 2003 10:20, Jens Axboe wrote:
> On Tue, Sep 16 2003, Ian Hastie wrote:
> > On Thursday 11 Sep 2003 22:52, Jens Axboe wrote:
> > > Surely the pro version supports open-by-device as well? And then it
> > > should work fine.
> >
> > It does.  However it also produces the same error message as cdrecord
> > when doing so, ie
> >
> > Warning: Open by 'devname' is unintentional and not supported.
> >
> > The implication being that it could go away or become broken at any time.
>
> I wouldn't read anything in to that if I were you. Joerg has some mis
> guided ideas about ATAPI addressing, but he would be a fool to remove
> open by devname at this point.

What about this version of the argument then?  There are a number if pieces of 
software, eg cdrdao, that don't support open by devname.  The kernel 
developers would be foolish to remove support for them at this time.  Works 
both ways doesn't it.

-- 
Ian.

