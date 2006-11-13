Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755191AbWKMQKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191AbWKMQKL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190AbWKMQKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:10:11 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:3308 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1755191AbWKMQKJ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:10:09 -0500
Message-Id: <200611131608.kADG8DIM004032@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Jeff Garzik <jeff@garzik.org>
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>,
       John Fremlin <not@just.any.name>,
       kernel list <linux-kernel@vger.kernel.org>, htejun@gmail.com,
       jim.kardach@intel.com
Subject: Re: AHCI power saving (was Re: Ten hours on X60s)
In-Reply-To: Your message of "Mon, 13 Nov 2006 10:48:53 EST."
             <455893E5.4010001@garzik.org>
From: Valdis.Kletnieks@vt.edu
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org> <20061113142219.GA2703@elf.ucw.cz> <45589008.1080001@garzik.org> <200611131637.56737.ak@suse.de>
            <455893E5.4010001@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1163434093_3121P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Nov 2006 11:08:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1163434093_3121P
Content-Type: text/plain; charset=us-ascii

On Mon, 13 Nov 2006 10:48:53 EST, Jeff Garzik said:
> Andi Kleen wrote:
> >> Therein lies a key problem.  Turning on all of AHCI's aggressive power 
> >> management features DOES save a lot of power.  But at the same time, it 
> >> shortens the life of your hard drive, particularly hard drives that are 
> >> really PATA, but have a PATA<->SATA bridge glued on the drive to enable 
> >> connection to SATA controllers.
> > 
> > How does it shorten its life?
> 
> Parks your hard drive heads many thousands of times more often than it 
> does without the aggressive PM features.

I've heard tell that the controller chip chews almost as much power as
the drive motor does - is there an option that says "Controller take a
snooze till we wake you up, but leave the drive spinning"?

--==_Exmh_1163434093_3121P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFWJhtcC3lWbTT17ARAkckAKCG0ZmcHcbmsE6+RGxchyYqfkME1gCdEBXi
jZKuc/B+vXx7SpZW7XyQeMQ=
=ggi2
-----END PGP SIGNATURE-----

--==_Exmh_1163434093_3121P--
