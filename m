Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270005AbUIDBZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270005AbUIDBZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 21:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269990AbUIDBZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 21:25:17 -0400
Received: from web14929.mail.yahoo.com ([216.136.225.94]:45665 "HELO
	web14929.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270005AbUIDBZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 21:25:11 -0400
Message-ID: <20040904012510.77417.qmail@web14929.mail.yahoo.com>
Date: Fri, 3 Sep 2004 18:25:10 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: New proposed DRM interface design
To: Dave Airlie <airlied@linux.ie>, Alex Deucher <alexdeucher@gmail.com>
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409040158400.25475@skynet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Dave Airlie <airlied@linux.ie> wrote:
> >
> > Will this redesign allow for multiple 3d accelerated cards in the
> same
> > machine?  could I have say an AGP radeon and a PCI radeon or a AGP
> > matrox and a PCI sis and have HW accel on :0 and :1.  If not, I
> think
> > it's something we should consider.
> 
> should be no problem at all, this is what I consider a DRM
> requirement so
> any design that doesn't fulfill it isn't acceptable...
> 
> of course implemented code may need a bit of testing :-)

I've been reworking the DRM code to better support two dissimilar video
card. I pratice on a PCI Rage128 and AGP Radeon. 

I would also like to start making infastructure changes to allow two
independently logged in users, one on each head. Multihead DRM cards
will show one device per head. If you set a merged fb mode the other
head will get disabled. 

This is the general plan I am working towards...
http://lkml.org/lkml/2004/8/2/111


=====
Jon Smirl
jonsmirl@yahoo.com


		
_______________________________
Do you Yahoo!?
Win 1 of 4,000 free domain names from Yahoo! Enter now.
http://promotions.yahoo.com/goldrush
