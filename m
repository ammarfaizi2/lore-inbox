Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVBZBA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVBZBA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 20:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVBZBAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 20:00:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:34969 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261426AbVBZA73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 19:59:29 -0500
Subject: Re: [Linux-fbdev-devel] Re: 2.6.11-rc5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050225212157.GA31227@suse.de>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
	 <20050224145049.GA21313@suse.de> <1109287708.15026.25.camel@gaston>
	 <20050225070813.GA13735@suse.de> <1109316551.14993.63.camel@gaston>
	 <20050225172945.GA31211@suse.de>
	 <Pine.LNX.4.56.0502251758370.20213@pentafluge.infradead.org>
	 <20050225202423.GA24282@suse.de>  <20050225212157.GA31227@suse.de>
Content-Type: text/plain
Date: Sat, 26 Feb 2005 11:58:28 +1100
Message-Id: <1109379509.14993.104.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 22:21 +0100, Olaf Hering wrote:
>  On Fri, Feb 25, Olaf Hering wrote:
> 
> >  On Fri, Feb 25, James Simmons wrote:
> > 
> > > 
> > > > cfb_imageblit(320) dst1 fa51a800 base e0b80000 bitstart 1999a800
> > > > fast_imageblit(237) s daea4000 dst1 fa51a800
> > > > fast_imageblit(269) j 1 fa51a800 0
> > > > Unable to handle kernel paging request at virtual address fa51a800
> > > > 
> > > > is bitstart incorrect or is the thing just not (yet) mapped?
> > > 
> > > Looks like the screen_base is not mapped to.
> > 
> > rc3 worked ok, rc4 does not. testing the -bk snapshots now.
> 
> bk8 works, bk9 breaks, it contains the radeonfb update.
> it works ok if the driver is compiled into the kernel.

Ah, that's a good point. Can you send me the dmesg outputs of in kernel
vs. in module with radeonfb verbose debug enabled ?

Ben.


