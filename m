Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTFOKPu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 06:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTFOKPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 06:15:50 -0400
Received: from [195.141.226.27] ([195.141.226.27]:8460 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S262115AbTFOKPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 06:15:49 -0400
Subject: Re: [Dri-devel] error in 2.5.70 compile with drm_radeon
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Thomas Magliery <magliery@csb.yale.edu>
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <3EEAC8D1.4020707@csb.yale.edu>
References: <3EEAC8D1.4020707@csb.yale.edu>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Debian, XFree86
Message-Id: <1055672977.23222.170.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 15 Jun 2003 12:29:37 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-14 at 09:03, Thomas Magliery wrote:
> 
> I am trying to compile kernel version 2.5.70 and I have a Mobility 
> Radeon 7500.  I selected DRM support in xconfig and DRM_RADEON as a 
> module.  I got the following error on compiling the kernel:
> 
> *** Warning: "flush_tlb_all" [drivers/char/drm/radeon.ko] undefined!

Looks like the kernel needs to export flush_tlb_all.


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

