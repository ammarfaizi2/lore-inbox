Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbTGYBv6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 21:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269354AbTGYBv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 21:51:58 -0400
Received: from dhcp065-024-128-253.columbus.rr.com ([65.24.128.253]:8072 "EHLO
	doug.hunley.homeip.net") by vger.kernel.org with ESMTP
	id S268019AbTGYBv4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 21:51:56 -0400
From: Douglas J Hunley <doug@hunley.homeip.net>
Organization: Linux StepByStep
To: Kurt Wall <kwall@kurtwerks.com>
Subject: Re: 2.6.0: Badness in pci_find_subsys!!
Date: Thu, 24 Jul 2003 22:06:34 -0400
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307241326.04656.doug@hunley.homeip.net> <200307241347.08124.doug@hunley.homeip.net> <20030724231008.GB28205@kurtwerks.com>
In-Reply-To: <20030724231008.GB28205@kurtwerks.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307242206.37779.doug@hunley.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Kurt Wall shocked and awed us all by speaking:
> Quoth Douglas J Hunley:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Greg KH shocked and awed us all by speaking:
> > > On Thu, Jul 24, 2003 at 01:26:01PM -0400, Douglas J Hunley wrote:
> > > > Just had my athlon box lock-up solid. needed SysRq to reboot the
> > > > thing.. kernel info follows:
> > > > Jul 24 13:08:23 doug kernel: Badness in pci_find_subsys at
> > > > drivers/pci/search.c:132
> > > > Jul 24 13:08:23 doug kernel: Call Trace:
> > > > Jul 24 13:08:23 doug kernel:  [<c02064a1>]
> > > > pci_find_subsys+0x111/0x120 Jul 24 13:08:23 doug kernel: 
> > > > [<c02064df>] pci_find_device+0x2f/0x40 Jul 24 13:08:23 doug kernel: 
> > > > [<c0206368>] pci_find_slot+0x28/0x50 Jul 24 13:08:23 doug kernel: 
> > > > [<f8a2ada4>] os_pci_init_handle+0x3a/0x67 [nvidia]
> > >
> > > You are using the nvidia driver.  Go complain to them as we can do
> > > nothing about their code, sorry.
> >
> > sure. I didn't know for sure that the fault was nvidia's.
>
> Do you get the same lock up *sans* the nvidia binary-only module?

dont know. haven't run 2.6 w/o the nvidia driver. this *never* locked up using 
the same nvidia driver under 2.4.x though
- -- 
Douglas J Hunley (doug at hunley.homeip.net) - Linux User #174778
http://doug.hunley.homeip.net && http://www.linux-sxs.org

Quando omni flunkus moritati (when all else fails play dead) 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IJCq2MO5UukaubkRAtXzAJ9u5U8peQ024B3kdEosilNrrNZtWACbBZX4
ieWcrn+zkd+QcD2//6imowA=
=JGSs
-----END PGP SIGNATURE-----

