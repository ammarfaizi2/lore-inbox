Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUGYILt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUGYILt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 04:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUGYILt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 04:11:49 -0400
Received: from camus.xss.co.at ([194.152.162.19]:31749 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S263740AbUGYILp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 04:11:45 -0400
Message-ID: <41036B3C.3010105@xss.co.at>
Date: Sun, 25 Jul 2004 10:11:40 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Rutt <rutt.4+news@osu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: clearing filesystem cache for I/O benchmarks
References: <87vfgeuyf5.fsf@osu.edu>
In-Reply-To: <87vfgeuyf5.fsf@osu.edu>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Benjamin Rutt wrote:
> How can I purge all of the kernel's filesystem caches, so I can trust
> that my I/O (read) requests I'm trying to benchmark bypass the kernel
> filesystem cache?

Some time ago I was looking for that, too, and found "cfree". Have a
look at <http://gizmolabs.org/~andrew/andrewweb/project.php?pid=3&tab=0>

It's a small utility and kernel module for linux-2.4 written by
Andrew de los Reyes. It allows to clear portions of the buffer cache
(e.g. for a complete sub-directory). I haven't analyzed it so I can't
say if it does things correctly, though.

HTH

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBA2s2xJmyeGcXPhERAuaTAKCaxNRjhbzf3G5uL1lsXYg41eF+jQCeP808
DNcut1YDptMCNsvAeXrt+d8=
=xPh9
-----END PGP SIGNATURE-----

