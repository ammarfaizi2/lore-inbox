Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263103AbVCMFAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbVCMFAp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 00:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVCMFAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 00:00:44 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:1156 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263103AbVCMFAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 00:00:32 -0500
Message-ID: <4233C912.80706@comcast.net>
Date: Sun, 13 Mar 2005 00:01:06 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
CC: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
Subject: Re: binary drivers and development
References: <423075B7.5080004@comcast.net> <423082BF.6060007@comcast.net>	 <16944.49977.715895.8761@wombat.chubb.wattle.id.au>	 <4230CB07.3020904@comcast.net> <6f6293f105031207535938c687@mail.gmail.com>
In-Reply-To: <6f6293f105031207535938c687@mail.gmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

You wanna give me a quick run-down on x86 of CPL and Ring levels?  It's
been bugging me.  I know they're there and have a basic idea that they
control what a context can do, don't know what CPL stands for, and
there's a visible gap in my knowledge.  I like to understand everything,
it makes things easier.

Felipe Alfaro Solana wrote:
> On Thu, 10 Mar 2005 17:32:39 -0500, John Richard Moser
> <nigelenki@comcast.net> wrote:
> 
>>CPL=3 scares me; context switches are expensive.  can they have direct
>>hardware access?  I'm sure a security model to isolate user mode drivers
>>could be in place. . .
>>
>>. . . huh.  Xen seems to run Linux at CPL=3 and give direct hardware
>>access, so I guess user mode drivers are possible *shrug*.  Linux isn't
>>a microkernel though.
> 
> 
> Xen hypervisor runs at Ring0, while the guest OSs it supports run at Ring1.
> 

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

iD8DBQFCM8kShDd4aOud5P8RAon1AKCLNWEbY3Vq32k61m9jN2CbSoD98QCeJT8m
mhgyXtmGNFL+RPzJw8md9hE=
=B/i5
-----END PGP SIGNATURE-----
