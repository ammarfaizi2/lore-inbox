Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268136AbUJMBBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268136AbUJMBBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 21:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268141AbUJMBBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 21:01:52 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:33710 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268136AbUJMBBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 21:01:49 -0400
Message-Id: <200410130059.i9D0xkJW028174@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: tglx@linutronix.de
Cc: Bill Huey <bhuey@lnxw.com>, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       amakarov@ru.mvista.com, ext-rt-dev@mvista.com,
       LKML <linux-kernel@vger.kernel.org>, Doug Niehaus <niehaus@ittc.ku.edu>
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel 
In-Reply-To: Your message of "Wed, 13 Oct 2004 01:10:34 +0200."
             <1097622634.19549.235.camel@thomas> 
From: Valdis.Kletnieks@vt.edu
References: <20041010084633.GA13391@elte.hu> <1097437314.17309.136.camel@dhcp153.mvista.com> <20041010142000.667ec673.akpm@osdl.org> <20041010215906.GA19497@elte.hu> <1097517191.28173.1.camel@dhcp153.mvista.com> <20041011204959.GB16366@elte.hu> <1097607049.9548.108.camel@dhcp153.mvista.com> <1097610393.19549.69.camel@thomas> <20041012211201.GA28590@nietzsche.lynx.com> <1097618415.19549.190.camel@thomas> <20041012223642.GB30966@nietzsche.lynx.com>
            <1097622634.19549.235.camel@thomas>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1006994892P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Oct 2004 20:59:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1006994892P
Content-Type: text/plain; charset=us-ascii

On Wed, 13 Oct 2004 01:10:34 +0200, Thomas Gleixner said:

> What have we at the very end ? A endless mess of non understandable
> macros, which are resolved by compiler magic ? Where nobody can see on
> the first look, which kind of concurrency control you are using ? That's
> a nice thing to do some proof of concept implementation, but it can not
> be a solution for something what is targeted to go into mainline. The
> frequency of T4-T7 patches including the small fixes posted on LKML is
> just a proof of this.

I seem to remember Ingo saying that this *is* still somewhat "proof of concept",
and that the gcc preprocessor ad-crockery was just a *really* nice way of doing
it semi-automagically while minimizing the patch footprint and intrusiveness.

I'm sure that once we've got a non-moving target, at least 2 or 3 levels
of preprocessor redirection will get cleaned up and removed, to save
future programmer's sanity..

(Viewed alternatively - how many more flubs would the T4-T7 series have
if Ingo wasn't using the preprocessor to do the heavy lifting?  For something
at the current level of cookedness, it's doing fairly well)...

--==_Exmh_-1006994892P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBbH4CcC3lWbTT17ARAoXWAJ9WXerTUjhn4JmeMGzNKThakWlz9QCg5nnJ
kIMYgHzRJcEDw7pOHOV8n+I=
=HkAr
-----END PGP SIGNATURE-----

--==_Exmh_-1006994892P--
