Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWISPiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWISPiR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWISPiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:38:17 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:8160 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751369AbWISPiQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:38:16 -0400
Message-Id: <200609191538.k8JFc6cY022534@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: rohitseth@google.com
Cc: Andrew Morton <akpm@osdl.org>, devel@openvz.org,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch03/05]- Containers: Initialization and Configfs interface
In-Reply-To: Your message of "Thu, 14 Sep 2006 18:41:26 PDT."
             <1158284486.5408.154.camel@galaxy.corp.google.com>
From: Valdis.Kletnieks@vt.edu
References: <1158284486.5408.154.camel@galaxy.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1158680286_3447P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Sep 2006 11:38:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1158680286_3447P
Content-Type: text/plain; charset=us-ascii

On Thu, 14 Sep 2006 18:41:26 PDT, Rohit Seth said:

> --- linux-2.6.18-rc6-mm2.org/kernel/container_configfs.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.18-rc6-mm2.ctn/kernel/container_configfs.c	2006-09-14 16:18:45.000000000 -0700

> +static ssize_t simple_containerfs_attr_show(struct config_item *item,
> +		struct configfs_attribute *attr,
> +		char *page)
...
> +	switch (ctfs_attr->idx) {
> +	case CONFIGFS_CTN_ATTR_ID:
> +		tmp = sc->ctn.id;
> +		break;
...
> +	return sprintf(page, "%ld\n", tmp);

What use is this value, given that we already have containers/user_friendly_name
to use in the filesystem namespace?  Or is this a mostly-debugging thing?

--==_Exmh_1158680286_3447P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFEA7ecC3lWbTT17ARAtCaAJ9qjH9TRzmeV4LDRs4Jj1D9EJMd3ACg7aU0
nqwBRDPZ9s5o9OmQOUFlZ5k=
=wsMP
-----END PGP SIGNATURE-----

--==_Exmh_1158680286_3447P--
