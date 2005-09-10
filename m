Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVIJMYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVIJMYw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVIJMYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:24:51 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:62548 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1750789AbVIJMYu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:24:50 -0400
Date: Sat, 10 Sep 2005 14:26:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: viro@ZenIV.linux.org.uk
Cc: Linus Torvalds <torvalds@osdl.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 2.6.13 1/20] aic94xx: Makefile
Message-ID: <20050910122623.GD18845@mars.ravnborg.org>
References: <4321E335.5010805@adaptec.com> <20050909201834.GA24521@mipter.zuzino.mipt.ru> <20050909201435.GB9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909201435.GB9623@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 09:14:35PM +0100, viro@ZenIV.linux.org.uk wrote:
> On Sat, Sep 10, 2005 at 12:18:34AM +0400, Alexey Dobriyan wrote:
> > On Fri, Sep 09, 2005 at 03:32:05PM -0400, Luben Tuikov wrote:
> > > --- linux-2.6.13-orig/drivers/scsi/aic94xx/Makefile
> > > +++ linux-2.6.13/drivers/scsi/aic94xx/Makefile
> > 
> > > +CHECK = sparse -Wbitwise
> > 
> > 	make C=1 CHECK="sparse -Wbitwise"
> > or
> > 	make C=1
> Or patch below and use make C=1 CF=-Wbitwise...
> 
> Allows to add to sparse arguments without mutilating makefiles - just
> pass CF=<arguments> and they will be added to CHECKFLAGS.

Applied - thanks.

	Sam
