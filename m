Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264708AbSIWCTL>; Sun, 22 Sep 2002 22:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264740AbSIWCTL>; Sun, 22 Sep 2002 22:19:11 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:52641
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S264708AbSIWCTK>; Sun, 22 Sep 2002 22:19:10 -0400
Message-ID: <3D8E7B93.5050608@redhat.com>
Date: Sun, 22 Sep 2002 19:25:23 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020812
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: first NPT vs. NGPT vs. LinuxThreads benchmark results
References: <3D8DB040.7060402@redhat.com> <20020923020451.GA3446@gnuppy.monkey.org>
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bill Huey (Hui) wrote:

> Which could mean that they, NGPT, have slower thread allocation algorithms
> for many reason. Some M:N systems will red zone protect a page of the thread
> stack adding overhead to creation and deletion

This is required by the standard and LinuxThreads and NPTL do this of 
course.  Don't know about NGPT, probably yes.

- -- 
- ---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9jnuX2ijCOnn/RHQRAmp/AKCO18uINcoAK8ezNQrp1T5GCtIYMwCgoBLP
mhfjJZxNrec3ZdcM4TXuy/w=
=MH/m
-----END PGP SIGNATURE-----

