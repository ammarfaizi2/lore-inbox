Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUDCQup (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 11:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUDCQup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 11:50:45 -0500
Received: from 65-248-111-151.cn.tx.cebridge.net ([65.248.111.151]:5016 "EHLO
	ns1.brianandsara.net") by vger.kernel.org with ESMTP
	id S261425AbUDCQun convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 11:50:43 -0500
From: Brian Jackson <brian@brianandsara.net>
Organization: brianandsara.net
To: Hans-Georg Esser <h.g.esser@gmx.de>
Subject: Re: 2.4.20 and 2.4.21, Firewire, 160 GB Harddisk, 134 GB barrier
Date: Sat, 3 Apr 2004 10:53:40 -0600
User-Agent: KMail/1.6.51
Cc: linux-kernel@vger.kernel.org
References: <406EC833.4080909@gmx.de>
In-Reply-To: <406EC833.4080909@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200404031053.41975.brian@brianandsara.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 03 April 2004 08:20, Hans-Georg Esser wrote:
> Hello list,
>
> I found an earlier thread ("KERNEL 2.6.3 and MAXTOR 160 GB", March 2004)
> dealing with a 137 GB barrier (that I guess meant: 137xxx MB) for a Maxtor
> 160 GB drive in Kernel 2.6.x. I'd like to add my personal observation to
> that (for Kernel 2.4.20/21):
>
> My drive (Western Digital WD1600BB-32DWA0) works well when directly
> connected to the IDE controller, but doesn't like using an external
> firewire connection ("Pyro 1394 Drive Kit" of Adstech.com). The firewire
> stuff worked well with an 80 GB disk, but with the 160 GB disk I'm only
> getting 134 GB (or 137439 MB).

The more likely scenario is that the bridge chip in said box doesn't support 
the larger drive and is the limiting factor.

- --Brian Jackson

>
> This may be related to the other post I mentioned, cause of the same
> "barrier" number. I haven't tried a newer kernel yet, this was with the
> standard kernel that came with the distro:
>
<snip>

- -- 
http://www.brianandsara.net
For Sale : http://www.brianandsara.net/temp/forsale.php
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAbuwU+cPN+Z7qK9cRAhLGAKCBgz1xf3MdypI4lPZBl3N/PRPg6QCgqCfR
su8H1F2RwQVXKYPGXIhsiXk=
=0g7r
-----END PGP SIGNATURE-----
