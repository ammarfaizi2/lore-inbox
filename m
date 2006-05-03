Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWECA1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWECA1G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 20:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWECA1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 20:27:06 -0400
Received: from h80ad2526.async.vt.edu ([128.173.37.38]:54223 "EHLO
	h80ad2526.async.vt.edu") by vger.kernel.org with ESMTP
	id S1751344AbWECA1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 20:27:04 -0400
Message-Id: <200605030026.k430QEf1003100@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       Arjan van de Ven <arjan@linux.intel.com>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       airlied@linux.ie, pjones@redhat.com, akpm@osdl.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access 
In-Reply-To: Your message of "Tue, 02 May 2006 18:19:14 MDT."
             <20060503001914.GA9609@parisc-linux.org> 
From: Valdis.Kletnieks@vt.edu
References: <1146300385.3125.3.camel@laptopd505.fenrus.org> <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com> <44578C92.1070403@linux.intel.com> <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com> <44579028.1020201@linux.intel.com> <9e4733910605021013h17b72453v3716f68a2cebdee1@mail.gmail.com> <1146594457.32045.91.camel@laptopd505.fenrus.org> <9e4733910605021200y6333a67sd2ff685f666cc6f9@mail.gmail.com> <21d7e9970605021440s6cdc3895t57617e5fad6c5050@mail.gmail.com> <9e4733910605021452r3aec1035pa475b701b2c3563c@mail.gmail.com>
            <20060503001914.GA9609@parisc-linux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1146615973_2530P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 02 May 2006 20:26:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1146615973_2530P
Content-Type: text/plain; charset=us-ascii

On Tue, 02 May 2006 18:19:14 MDT, Matthew Wilcox said:

> I suppose SELinux might be able to help, but I don't care to get into
> that discussion here ;-)

The RedHat patch splatting most of /dev/mem would help more than SELinux would.
(Of course, that assumes that the offending address space is someplace that
X doesn't actually need itself, and that the patch blocks access to....)

--==_Exmh_1146615973_2530P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEV/ilcC3lWbTT17ARAl/aAKCsL1jFzfSHv8iAIdgnSOX87TNP3QCgxaeI
ODfTmxBWrg4uvj7hqhIgqcI=
=SkpF
-----END PGP SIGNATURE-----

--==_Exmh_1146615973_2530P--
