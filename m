Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263311AbSITS73>; Fri, 20 Sep 2002 14:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263323AbSITS73>; Fri, 20 Sep 2002 14:59:29 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:40841
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S263311AbSITS72>; Fri, 20 Sep 2002 14:59:28 -0400
Message-ID: <3D8B7157.6040205@redhat.com>
Date: Fri, 20 Sep 2002 12:04:55 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020812
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
References: <Pine.NEB.4.44.0209201144270.2586-100000@mimas.fachschaften.tu-muenchen.de>
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Adrian Bunk wrote:

> My personal estimation is that Debian will support kernel 2.4 in it's
> stable distribution until 2006 or 2007 (this is based on the experience
> that Debian usually supports two stable kernel series and the time between
> stable releases of Debian is > 1 year). What is the proposed way for
> distributions to deal with this?

Two ways:

- - continue to use the old code

- - backport the required functionality


Note that not all the changes Ingo made have to be ported back to 2.4. 
Only those required for correct execution, not the optimizations.

Whether Marcello is interested in this I cannot say, I doubt it though. 
  But this does not mean you cannot have such a kernel in Debian.

- -- 
- ---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9i3Fb2ijCOnn/RHQRAlC+AJ9kXWMdkfuORtodijTXQ+Hnah0ZYQCfZkOT
Axzw/z1VEFVXIQdZ4d8PLe4=
=ptvg
-----END PGP SIGNATURE-----

