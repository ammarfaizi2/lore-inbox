Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267539AbTALVke>; Sun, 12 Jan 2003 16:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbTALVke>; Sun, 12 Jan 2003 16:40:34 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:36701 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267539AbTALVkd>; Sun, 12 Jan 2003 16:40:33 -0500
Message-ID: <3E21E2DC.2010301@blue-labs.org>
Date: Sun, 12 Jan 2003 16:49:16 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030110
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: robw@optonline.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <20030112211530.GP27709@mea-ext.zmailer.org> <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
In-Reply-To: <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
X-Enigmail-Version: 0.71.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

<sarcasm> An even worse misuse, exiting the function from random 
locations avoiding logic completion </sarcasm>

David

Rob Wilkens wrote:

> 	error = -EINVAL;
> 	if (length < 0)	/* sorry, but loff_t says... */
>-		goto out;
>+		return error;
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+IeLc74cGT/9uvgsRAmVKAJ0eNNXPL9vjCdkoaSGo0V9ZCihdNQCgg5np
WKKq3YLs+Iz3mbDynww2Zk0=
=R9xZ
-----END PGP SIGNATURE-----

