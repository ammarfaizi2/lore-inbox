Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbUDFSOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263935AbUDFSOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:14:32 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:46009 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263928AbUDFSOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:14:30 -0400
Date: Tue, 6 Apr 2004 19:11:46 +0100
From: Dave Jones <davej@redhat.com>
To: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
Cc: Bjoern Michaelsen <bmichaelsen@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Message-ID: <20040406181146.GH6930@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>,
	Bjoern Michaelsen <bmichaelsen@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20040406031949.GA8351@lord.sinclair> <20040406134709.GB32405@redhat.com> <200404062004.34413.volker.hemmann@heim10.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404062004.34413.volker.hemmann@heim10.tu-clausthal.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 08:04:34PM +0200, Hemmann, Volker Armin wrote:

 > Now I did, what I should have done at the first place, dmesg:
 > 
 > Linux agpgart interface v0.100 (c) Dave Jones
 > agpgart: Detected SiS 746 chipset
 > agpgart: Maximum main memory to use for agp memory: 439M
 > agpgart: unable to determine aperture size.
 > agpgart: agp_backend_initialize() failed.
 > agpgart-sis: probe of 0000:00:00.0 failed with error -22

something isn't right here. this takes us right back to where we
were before your first email about this problem.
Did the patch definitly apply to the tree you compiled ?
Not booted into the wrong kernel by mistake ?

 > I am rebooting after the mail back to 2.6.5-rc3 with the 'old' patches from 
 > last week, because even 2D is real slow now...

that's an nvidia problem, agpgart has no interaction with 2d whatsoever.

		Dave

