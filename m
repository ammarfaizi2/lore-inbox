Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274586AbSITX2o>; Fri, 20 Sep 2002 19:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275117AbSITX2k>; Fri, 20 Sep 2002 19:28:40 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:3981 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S274586AbSITX2P>; Fri, 20 Sep 2002 19:28:15 -0400
Message-ID: <3D8BB044.5010107@redhat.com>
Date: Fri, 20 Sep 2002 16:33:24 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020812
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
References: <Pine.NEB.4.44.0209201144270.2586-100000@mimas.fachschaften.tu-muenchen.de> <3D8B7157.6040205@redhat.com> <20020920230634.GA1555@werewolf.able.es>
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

J.A. Magallon wrote:

> Could you post a list of requirements ? For example:
> - kernel: futexes, per_cpu_areas

There's a lot more.  The signal handling, the exec handling, the exit 
handling, the clone extensions.


> - toolchain: binutils version + RH-patches, gcc version

No RH patches.  Don't spread misinformation.

All the changes needed for kernel, glibc, and the tools are in the 
official sources trees.  It's just that nobody else ships those versions 
or versions with the necessary features backported.


> - glibc: 2.2.xxxx

The announcement said it clearly: you need at least the 2.3 prerelease 
of as yesterday.   Again, all in the public archive.

- -- 
- ---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9i7BI2ijCOnn/RHQRAn0nAKCF4cZO9K2/vhNbCuawvk0ecM2SCQCeOKE9
Qg19wkleGKXFmr3plY1dbho=
=oWVM
-----END PGP SIGNATURE-----

