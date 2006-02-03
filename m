Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422931AbWBCUrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422931AbWBCUrV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422937AbWBCUrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:47:21 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:65030 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1422931AbWBCUrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:47:20 -0500
Date: Fri, 3 Feb 2006 21:47:12 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203204712.GA84752@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
References: <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <20060203180421.GA57965@dspnet.fr.eu.org> <43E3B3F3.8060107@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E3B3F3.8060107@cfl.rr.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 02:50:11PM -0500, Phillip Susi wrote:
> Olivier Galibert wrote:
> >Actually, since at that point in time HAL is the only way to do device
> >discovery with the linux kernel, problems in HAL are problems in
> >linux.  There is *no* other way than HAL to do the mapping between a
> >point in the sysfs tree and a device node in /dev[1].
> 
> That information is available in /sys, which is how HAL discovers it.  

No, it isn't.  OTOH, udev maintains it, so I guess that's good enough.
It makes udev the kernel interface though.  I hope they now care about
compatibility (/dev/.udev.pdb vs. /dev/.udev/db/* anyone?).


> If you wanted to, you could bypass HAL and go directly to /sys to 
> perform your own discovery.  Also HAL is not a part of the linux kernel, 
> therefore a problem in HAL is NOT a problem in linux, even if there were 
> no other way to get the information as you ( wrongly ) asserted. 

Bullshit.  If <x> is the only interface available to a kernel service,
then <x> is part of the kernel whether you like it or not.  Case in
point, the ALSA library.

  OG.

