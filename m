Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVC1SvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVC1SvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 13:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVC1SvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 13:51:23 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:48827 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261993AbVC1SvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 13:51:01 -0500
Message-ID: <4248520E.1070602@comcast.net>
Date: Mon, 28 Mar 2005 13:50:54 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, ubuntu-hardened@lists.ubuntu.com
Subject: Re: Collecting NX information
References: <42484B13.4060408@comcast.net> <1112035059.6003.44.camel@laptopd505.fenrus.org>
In-Reply-To: <1112035059.6003.44.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
>>As I understand, PT_GNU_STACK uses a single marking to control whether a
>>task gets an executable stack and whether ASLR is applied to the
>>executable.
> 
> 
> you understand wrongly.
> 
> PT_GNU_STACK just sets the exec permission for the stack (and the heap
> now mirrors the stack). Nothing more nothing less.
> 

So then this would be slightly more useful than I had previously
thought, bringing control over the randomization as well?

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCSFINhDd4aOud5P8RAv36AJ9kFyE4u14CAVvWNu4bl11Gd125agCfVj3I
gNPQRd73mWJCLrPd5Ge/EnM=
=jqg0
-----END PGP SIGNATURE-----
