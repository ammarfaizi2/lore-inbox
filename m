Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWDMUog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWDMUog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWDMUog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:44:36 -0400
Received: from ns2.suse.de ([195.135.220.15]:63164 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932463AbWDMUof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:44:35 -0400
Message-ID: <443EB829.1040309@suse.com>
Date: Thu, 13 Apr 2006 16:44:25 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 01/08] idr: add idr_replace method for replacing pointers
References: <20060413203546.GA3181@locomotive.unixthugs.org>
In-Reply-To: <20060413203546.GA3181@locomotive.unixthugs.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Mahoney wrote:
> --- linux-2.6.16-staging1/lib/idr.c	2006-01-02 22:21:10.000000000 -0500
> +++ linux-2.6.16-staging2/lib/idr.c	2006-04-13 16:18:14.000000000 -0400
> @@ -390,6 +390,43 @@ void *idr_find(struct idr *idp, int id)
>  }
>  EXPORT_SYMBOL(idr_find);
>  
> +/**
> + * idr_replace - replace pointer for given id
> + * @idp: idr handle
> + * @ptr: pointer you want associated with the ide
> + * @id: lookup key
> + *
> + * Replace the pointer registered with the id.  A -ENOENT
> + * return indicates that @id is not found.

This was accidentally sent. It's a vim backup file. Just a grammar
change from the one that I'm not replying to. Sorry for the confusion.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEPrgpLPWxlyuTD7IRAlp1AJsGHFot4YULH2+wJd02zJ3H1HxWqwCfT/r3
aUvCCekPGHiQfaZXyOTx6oM=
=tFd9
-----END PGP SIGNATURE-----
