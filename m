Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUC3Hk1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbUC3Hk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:40:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15326 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263340AbUC3Hjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:39:33 -0500
Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
	sched-2.6.5-rc2-mm2-A3
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, mingo@elte.hu,
       jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
In-Reply-To: <20040330091323.5c0f557a.ak@suse.de>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>
	 <20040325154011.GB30175@wotan.suse.de> <20040325190944.GB12383@elte.hu>
	 <20040325162121.5942df4f.ak@suse.de> <20040325193913.GA14024@elte.hu>
	 <20040325203032.GA15663@elte.hu> <20040329084531.GB29458@wotan.suse.de>
	 <4068066C.507@yahoo.com.au> <20040329080150.4b8fd8ef.ak@suse.de>
	 <20040329114635.GA30093@elte.hu> <20040329221434.4602e062.ak@suse.de>
	 <4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de>
	 <40691BCE.2010302@yahoo.com.au>  <20040330091323.5c0f557a.ak@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WxBIz8Zjk+E3fykLEu9B"
Organization: Red Hat, Inc.
Message-Id: <1080632295.4679.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 30 Mar 2004 09:38:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WxBIz8Zjk+E3fykLEu9B
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Regression on what workload? The 2.4 kernel who did the
> early balancing didn't seem to have problems.

well the hard balance is between a program that just splits of one
thread and has those 2 threads working closely together (in which case
you want the 2 threads to be together on the same quad in a quad-like
setup) and a program that splits of a thread and has the 2 threads
working basically entirely independent.

Benchmarks are typically of the later kind... but real world
applications ???? The ones I can think of using threads are of the
former kind.

--=-WxBIz8Zjk+E3fykLEu9B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAaSPnxULwo51rQBIRAs+1AJwMbEjf6jyHm6VHj9MY4LS4G3qfnwCgluMZ
1xovZdzKDH0rHM/KEjvy5uY=
=aoLR
-----END PGP SIGNATURE-----

--=-WxBIz8Zjk+E3fykLEu9B--

