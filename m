Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUI1TaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUI1TaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 15:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267721AbUI1TaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 15:30:10 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:36360 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267700AbUI1T36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 15:29:58 -0400
Date: Tue, 28 Sep 2004 21:35:07 +0200
To: Ian Romanick <idr@us.ibm.com>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Xserver development <xorg@freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
Message-ID: <20040928193507.GA5550@hh.idb.hist.no>
References: <9e4733910409280854651581e2@mail.gmail.com> <415997C6.1060802@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415997C6.1060802@us.ibm.com>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 09:56:38AM -0700, Ian Romanick wrote:
> Jon Smirl wrote:
>
[...] 
> >After sometime testing and fixing obvious problems I'll generate a
> >patch for the 2.6 kernel and lkml.
> >
> >[root@smirl linux-2.6]# lsmod | more
> >Module                  Size  Used by
> >tdfx                    2816  0
> >sis                    10176  0
> >mga                    56704  0
> >i915                   16896  0
> >via                    19428  0
> >savage                  3840  0
> >r128                   44672  0
> >radeon                 70272  0
> >drm                    59684  8 tdfx,sis,mga,i915,via,savage,r128,radeon
> 
> Anyone have a PCI card so that we can test actually using more than one 
> at a time?  In the mean time, I think just having them all load at once 
> and one of them work is good enough.

I have a radeon9200SE pci card, and a matrox G550 agp card.  I can try
when that 2.6 patch becomes available.

Helge Hafting
