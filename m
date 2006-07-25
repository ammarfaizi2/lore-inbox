Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWGYTlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWGYTlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWGYTlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:41:03 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:56717 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932159AbWGYTlA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:41:00 -0400
Message-Id: <200607251940.k6PJeWbu023928@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Al Boldi <a1426z@gawab.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.4 for 2.6.18-rc2
In-Reply-To: Your message of "Tue, 25 Jul 2006 21:27:14 +0300."
             <200607252127.14024.a1426z@gawab.com>
From: Valdis.Kletnieks@vt.edu
References: <200607241857.52389.a1426z@gawab.com> <200607250757.10722.a1426z@gawab.com> <44C5AFC3.4020405@bigpond.net.au>
            <200607252127.14024.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153856431_3092P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Jul 2006 15:40:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153856431_3092P
Content-Type: text/plain; charset=us-ascii

On Tue, 25 Jul 2006 21:27:14 +0300, Al Boldi said:
> Peter Williams wrote:

> > It's probably not a good idea to have different schedulers managing the
> > same resource.  The way to do different scheduling per process is to use
> > the scheduling policy mechanism i.e. SCHED_FIFO, SCHED_RR, etc.
> > (possibly extended) within each scheduler.  On the other hand, on an SMP
> > system, having a different scheduler on each run queue (or sub set of
> > queues) might be interesting :-).  
> 
> What's wrong with multiple run-queues on UP?

On an SMP system, you can have one CPU doing one class of scheduling (long
timeslice for computational, for example), while another CPU is dedicated
to doing RT scheduling, and so on.  It's not clear to me that "different
classes per CPU" makes any real sense on a UP....

--==_Exmh_1153856431_3092P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFExnOvcC3lWbTT17ARAtEvAKDuTAQcmfndqCwGHi0PRQlp2Qn2oACeO+61
Jnkvw2SK7LbGTGqTLcR6x6I=
=An9W
-----END PGP SIGNATURE-----

--==_Exmh_1153856431_3092P--
