Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269589AbTGXRdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 13:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269602AbTGXRcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 13:32:24 -0400
Received: from dhcp065-024-128-253.columbus.rr.com ([65.24.128.253]:55425 "EHLO
	doug.hunley.homeip.net") by vger.kernel.org with ESMTP
	id S269589AbTGXRcG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 13:32:06 -0400
From: Douglas J Hunley <doug@hunley.homeip.net>
Organization: Linux StepByStep
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.0: Badness in pci_find_subsys!!
Date: Thu, 24 Jul 2003 13:47:04 -0400
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307241326.04656.doug@hunley.homeip.net> <20030724173526.GA7952@kroah.com>
In-Reply-To: <20030724173526.GA7952@kroah.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307241347.08124.doug@hunley.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH shocked and awed us all by speaking:
> On Thu, Jul 24, 2003 at 01:26:01PM -0400, Douglas J Hunley wrote:
> > Just had my athlon box lock-up solid. needed SysRq to reboot the thing..
> > kernel info follows:
> > Jul 24 13:08:23 doug kernel: Badness in pci_find_subsys at
> > drivers/pci/search.c:132
> > Jul 24 13:08:23 doug kernel: Call Trace:
> > Jul 24 13:08:23 doug kernel:  [<c02064a1>] pci_find_subsys+0x111/0x120
> > Jul 24 13:08:23 doug kernel:  [<c02064df>] pci_find_device+0x2f/0x40
> > Jul 24 13:08:23 doug kernel:  [<c0206368>] pci_find_slot+0x28/0x50
> > Jul 24 13:08:23 doug kernel:  [<f8a2ada4>] os_pci_init_handle+0x3a/0x67
> > [nvidia]
>
> You are using the nvidia driver.  Go complain to them as we can do
> nothing about their code, sorry.

sure. I didn't know for sure that the fault was nvidia's.
- -- 
Douglas J Hunley (doug at hunley.homeip.net) - Linux User #174778
http://doug.hunley.homeip.net && http://www.linux-sxs.org

What am I?... Flypaper for freaks!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IBuY2MO5UukaubkRAiBrAJ9ScHHY8Z7Otu733OOhMAUgZkraDgCfb6tn
dsvrskTMQXSSWK4wejtpBes=
=vUV7
-----END PGP SIGNATURE-----

