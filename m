Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTICQ0K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTICQYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:24:37 -0400
Received: from lpbproductions.com ([68.98.208.147]:49549 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S263546AbTICQYA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:24:00 -0400
From: Matt Heler <lkml@lpbproductions.com>
To: dth@ncc1701.cistron.net (Danny ter Haar), linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx doesn't work
Date: Wed, 3 Sep 2003 09:23:55 -0700
User-Agent: KMail/1.5.9
References: <bj447c$el6$1@news.cistron.nl>
In-Reply-To: <bj447c$el6$1@news.cistron.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200309030924.00296.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is also apparent in the 2.4.22 stable kernel .. I wasn't able to get my 
via-rhine to work at all either..  Instead of turning off acpi I just put in 
a spare 3com card I had lying around.. Still if this is in both the 2.6 and 
now the 2.4 kernel 's .. shouldnt someone fix it ? 


On Wednesday 03 September 2003 12:11 am, Danny ter Haar wrote:
> Subject says all! :-)
>
> 2.6.0-test3-mm2 still works (as does 2.4.21-rc2).
>
> vanilla 2.6.0-test4 & test4-mm[45] & the onboard ethernet doesn't seem to
> work. No kernel panics, it just doesn't work :-(
>
>
> Both have same ethernet driver:
>
> via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
>   http://www.scyld.com/network/via-rhine.html
> eth0: VIA VT6102 Rhine-II at 0xe800, 00:40:63:ca:6a:c1, IRQ 10.
> eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
> eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
>
> Even manual config (normal is dhcp) doesn't work.
>
> Haven't seen anyone else report this, but this is repeatable and i suspect
> more people must have experienced this ?!
>
> Machine is running debian-unstable distro.
>
> Danny
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/VhWeleY/n9G/oZ8RApDNAJwIHkz1zrLERkQ1Y604wcujOYN3HACfbMtW
sHrPFwycxKgo5URgqovSGbI=
=247w
-----END PGP SIGNATURE-----
