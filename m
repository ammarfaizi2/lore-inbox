Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVCCVS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVCCVS7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVCCVQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:16:55 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:15653 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262480AbVCCVOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:14:33 -0500
Message-ID: <42277ED8.6050500@suse.com>
Date: Thu, 03 Mar 2005 16:17:12 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] openfirmware: adds sysfs nodes for openfirmware	devices
References: <20050301211824.GC16465@locomotive.unixthugs.org> <1109806334.5611.121.camel@gaston> <42275536.8060507@suse.com> <20050303202319.GA30183@suse.de>
In-Reply-To: <20050303202319.GA30183@suse.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Olaf Hering wrote:
>  On Thu, Mar 03, Jeff Mahoney wrote:
> 
> 
>>Is whitespace (in any form) allowed in the compatible value?
> 
> 
> Yes, whitespace is used at least in the toplevel compatible file, like
> 'Power Macintosh' in some Pismo models.
> 

Oh well, it was wishful thinking anyway. ;)

I see two potential solutions:
* Ideally, I'd like to find a character (pipe?) that isn't used in the
  Apple OF compatible property. I've been unable to find any
  documentation that specifies to this level of detail. (Well, without
  paying for the IEEE-1275 reference, and it may not even be there.)

* Looking at other hotplug agents, it seems acceptable to use $DEVPATH
  to read attributes directly from sysfs. This wouldn't be difficult to
  add to my macio agent, but doesn't seem as nice.

To be frank, my experiences with OF are limited to getting my airport
card to work with this code. That was the initial goal, and I figured it
was code other people might want to use as well. If someone has the
answers to these questions, it would be appreciated.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCJ37XLPWxlyuTD7IRAimZAJ4kAWQwFur1mBB4RDpC3OfDCVpOWACeKQGg
YOoSQu4IGt9zmKNCmTjd6UI=
=yICe
-----END PGP SIGNATURE-----
