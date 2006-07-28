Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161352AbWG1XOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161352AbWG1XOm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 19:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161361AbWG1XOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 19:14:42 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:53202 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1161352AbWG1XOl (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 19:14:41 -0400
Message-Id: <200607282314.k6SNESSg019274@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Shem Multinymous <multinymous@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
In-Reply-To: Your message of "Sat, 29 Jul 2006 01:10:40 +0300."
             <41840b750607281510j2c5babf8x9fac51fe6910aeda@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz> <20060728134307.GD29217@suse.cz> <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com> <200607281557.k6SFvn09022794@turing-police.cc.vt.edu>
            <41840b750607281510j2c5babf8x9fac51fe6910aeda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154128468_2994P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 19:14:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1154128468_2994P
Content-Type: text/plain; charset=us-ascii

On Sat, 29 Jul 2006 01:10:40 +0300, Shem Multinymous said:
> On 7/28/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> > Is there a reliable (or hack-worthy) way for the kernel to determine how
> > often the values are re-posted by the hardware?
> 
> That's hardware-specific. Some drivers can know, others may just
> assume 1sec or 0.1sec or whatever.

That smells suspiciously like "We need an API for the hardware-specific
bits f code to pass the generic bits a value for this..." (and the
hardware-specific part can either ask the battery, or return a
hard-coded "10 seconds" that somebody measured, or whatever)....

--==_Exmh_1154128468_2994P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEyppUcC3lWbTT17ARAlN1AJ9cEta6uWR1gBUHzwGHlc2lhdRbswCg22AP
S9K/y9joglH8omXwf9DMMgY=
=yZY6
-----END PGP SIGNATURE-----

--==_Exmh_1154128468_2994P--
