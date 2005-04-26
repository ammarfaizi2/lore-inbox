Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVDZDws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVDZDws (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 23:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVDZDws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 23:52:48 -0400
Received: from h80ad2469.async.vt.edu ([128.173.36.105]:31502 "EHLO
	h80ad2469.async.vt.edu") by vger.kernel.org with ESMTP
	id S261333AbVDZDwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 23:52:30 -0400
Message-Id: <200504260352.j3Q3qGEP010127@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] dlm: build 
In-Reply-To: Your message of "Mon, 25 Apr 2005 14:25:25 PDT."
             <20050425142525.70e72e93.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20050425151333.GH6826@redhat.com>
            <20050425142525.70e72e93.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1114487535_3571P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Apr 2005 23:52:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1114487535_3571P
Content-Type: text/plain; charset=us-ascii

On Mon, 25 Apr 2005 14:25:25 PDT, Andrew Morton said:
> David Teigland <teigland@redhat.com> wrote:
> >
> >  +config DLM 

> Shouldn't it enable SCTP?  Depend on NET?

Looks like it.  As a related question, is the SCTP dependency something
fairly innate to the design, or would layering it over other low-level
transports in the future be a possibility? A first glance makes it look
like only lowcomms.c and maybe midcomms.c would be affected.


--==_Exmh_1114487535_3571P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCbbrvcC3lWbTT17ARAkbKAKCJe/XkGyVL5npeFhmoXNqQ2f4s5QCgvpoF
kA2BV++YAgWRIyp7iAPCTlQ=
=cbV4
-----END PGP SIGNATURE-----

--==_Exmh_1114487535_3571P--
