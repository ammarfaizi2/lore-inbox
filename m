Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265328AbUAFDMX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 22:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbUAFDMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 22:12:22 -0500
Received: from h80ad2537.async.vt.edu ([128.173.37.55]:8320 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266065AbUAFDKT (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 22:10:19 -0500
Message-Id: <200401060309.i0639uEg002449@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Dax Kelson <dax@gurulabs.com>
Cc: "Yu, Luming" <luming.yu@intel.com>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, "Brown, Len" <len.brown@intel.com>
Subject: Re: [ACPI] ACPI battery issue - Dell Inspiron 4150 - 2.6.1-rc1-mm2 
In-Reply-To: Your message of "Mon, 05 Jan 2004 19:27:38 MST."
             <1073356057.2687.2.camel@mentor.gurulabs.com> 
From: Valdis.Kletnieks@vt.edu
References: <3ACA40606221794F80A5670F0AF15F8401720C78@PDSMSX403.ccr.corp.intel.com>
            <1073356057.2687.2.camel@mentor.gurulabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_311795388P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jan 2004 22:09:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_311795388P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 Jan 2004 19:27:38 MST, Dax Kelson said:

> Seems to work ... is it normal to have the "unknown" values below when
> plugged in?
> 
> $ cat /proc/acpi/battery/BAT0/state
> present:                 yes
> capacity state:          ok
> charging state:          unknown
> present rate:            unknown
> remaining capacity:      66000 mWh
> present voltage:         16501 mV

I can't say for certain, but I think it's a tad confused - it can report 
'charging', and 'discharging', but doesn't know what to say if the battery
is at 100% and you're running off AC....It's been that way on mine at
least since 2.5.7mumble or maybe 2.4.18, so it's NOT a regression from the
recent ACPI patch.

--==_Exmh_311795388P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/+icEcC3lWbTT17ARAtMZAJ93stfHRUoxG50eeFB7+YRrqh3aVACgm1gE
xKBbT9pJfs3vMpvRx6fZvOg=
=Re/0
-----END PGP SIGNATURE-----

--==_Exmh_311795388P--
