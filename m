Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTHSTTl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbTHSTSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:18:38 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:11491
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261265AbTHSTQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:16:40 -0400
Message-ID: <3F427766.5020105@redhat.com>
Date: Tue, 19 Aug 2003 12:15:50 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030731 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6
References: <3F4268C1.9040608@redhat.com> <20030819210623.A2195@pclin040.win.tue.nl>
In-Reply-To: <20030819210623.A2195@pclin040.win.tue.nl>
X-Enigmail-Version: 0.81.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andries Brouwer wrote:

> I just tried NFS client 2.6.0-test3, NFS server 2.0.34, try test on client.
> No problems. ftruncate did not fail.
> 
> (Do you require some NFS version?)

I have no special settings.  It's an out-of-the-box RHL9 server setting,
using NFSv3.  Mounted with "rw,intr".  It's mounted by autofs but this
shouldn't be of any concern here.

I can reproduce it at will and if somebody needs more info, no problem.
 The server should be fine.  I can do the same from another RHL9 machine
or any of our more recent kernels and it works just fine.  It's only the
2.6 kernel client which fails.

Does the 2.0 kernel have NFSv3?  That might be why you don't see it.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/Qndn2ijCOnn/RHQRAsseAJ4zYB4GQTswat4jc0yaC2rbP/hlwQCeOfae
Bx2OFb/XFNVH7epLaKaRZIY=
=SDRK
-----END PGP SIGNATURE-----

