Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVBQTL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVBQTL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVBQTKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:10:25 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:49344 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262350AbVBQTIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:08:21 -0500
Date: Thu, 17 Feb 2005 20:08:15 +0100
To: Stefan =?iso-8859-15?Q?D=F6singer?= <stefandoesinger@gmx.at>
Cc: acpi-devel@lists.sourceforge.net,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       Pavel Machek <pavel@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
Message-ID: <20050217190815.GC4925@gamma.logic.tuwien.ac.at>
References: <20050214211105.GA12808@elf.ucw.cz> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at> <200502152038.00401.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200502152038.00401.stefandoesinger@gmx.at>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 15 Feb 2005, Stefan Dösinger wrote:
> > - DRI must be disabled I guess?! Even with newer X server (x.org)?
> Do you use the fglrx driver? This doesn't work with any type of suspend so 
> far. If you use the radeon driver try a driver update.

Ok, I installed xlibmesa-gl1-dri-trunk, xserver-xfree86-dri-trunk and
compiled linux-2.6.11-rc4 and drm modules from drm-trunk-module-src, all
from http://www.nixnuts.net/files/

But I had no success whatsoever. With this (Xorg server, current dri/drm
stuff, ..) the laptop not even wakes up from sleep!

Now I am back at debian XFree 4.3.0.1 and DRI disabled and suspend works
again.

I don't know wether this is a problem with the kernel or the drm, so to
sum up:

- kernel 2.6.11-rc3-mm2, XFree 4.3.0.1 (debian/sid), no dri
	works

- kernel 2.6.11-rc4, Xorg 6.8.1.99 (debian sid + nixnuts), drm cvs, drm 
  activated
	no resume (thus also no test for X)


Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SWANIBOST (adj.)
Complete shagged out after a hard day having income tax explained to
you.
			--- Douglas Adams, The Meaning of Liff
