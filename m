Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbTILIts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 04:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbTILIts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 04:49:48 -0400
Received: from gate.firmix.at ([80.109.18.208]:52101 "EHLO tara.firmix.at")
	by vger.kernel.org with ESMTP id S261307AbTILItq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 04:49:46 -0400
Subject: Re: [BK PATCH] One strdup() to rule them all
From: Bernd Petrovitsch <bernd@firmix.at>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Andries Brouwer <aebr@win.tue.nl>, Jakub Jelinek <jakub@redhat.com>,
       Dan Aloni <da-x@gmx.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com
In-Reply-To: <20030912050729.331442C11B@lists.samba.org>
References: <20030912050729.331442C11B@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063356560.29315.4.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 12 Sep 2003 10:49:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fre, 2003-09-12 at 06:16, Rusty Russell wrote:
> In message <3F6139AD.6070603@pobox.com> you write:
> > Of course, if we DO waste time on it, your implementation Rusty kicks 
> > ass and takes steroids :)
> 
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test5-bk2/MAINTAINERS working-2.6.0-test5-bk2-modules_txt_kconfig1/MAINTAINERS
> --- linux-2.6.0-test5-bk2/MAINTAINERS	2003-09-09 10:34:22.000000000 +1000
> +++ working-2.6.0-test5-bk2-modules_txt_kconfig1/MAINTAINERS	2003-09-12 14:15:42.000000000 +1000
> @@ -1102,6 +1102,13 @@ W:	http://nfs.sourceforge.net/
>  W:	http://www.cse.unsw.edu.au/~neilb/patches/linux-devel/
>  S:	Maintained
>  
> +KSTRDUP
> +P:	Kstrdup Core Team
> +M:	kstrdup-core@ozlabs.org
> +L:	kstrdup@linux.kernel.org
> +W:	http://kstrdup.sourceforge.net/
> +S:	Supported
> +
>  LANMEDIA WAN CARD DRIVER
>  P:	Andrew Stanley-Jones
>  M:	asj@lanmedia.com
> 
> Kill me now,

;-)

And kcalloc() [or whatever it should be called] falls probably in the
same category.


	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services
