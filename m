Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVHIU2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVHIU2l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbVHIU2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:28:41 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:24002 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964935AbVHIU2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:28:40 -0400
Message-Id: <200508092028.j79KSVYW028307@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: capabilities patch (v 0.1) 
In-Reply-To: Your message of "Tue, 09 Aug 2005 07:26:21 +0200."
             <20050809052621.GA7970@clipper.ens.fr> 
From: Valdis.Kletnieks@vt.edu
References: <20050809052621.GA7970@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1123619310_21136P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 09 Aug 2005 16:28:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1123619310_21136P
Content-Type: text/plain; charset=us-ascii

On Tue, 09 Aug 2005 07:26:21 +0200, David Madore said:

> * Second, a much more extensive change, the patch introduces a third
> set of capabilities for every process, the "bounding" set.  Normally
> the bounding set has every capability in it

How is this different in semantics from the existing 'permitted' capset?

include/linux/capabilities.h:

typedef struct __user_cap_data_struct {
        __u32 effective;
        __u32 permitted;
        __u32 inheritable;
} __user *cap_user_data_t;


--==_Exmh_1123619310_21136P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFC+RHucC3lWbTT17ARAp+eAJ4rv24vYaIWC01XH/qef7gwgl/+gQCeP46o
KRFx6UKyaxjW00VPYuQABcY=
=zGCN
-----END PGP SIGNATURE-----

--==_Exmh_1123619310_21136P--
