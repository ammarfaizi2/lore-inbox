Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUHDMHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUHDMHk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 08:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUHDMHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 08:07:40 -0400
Received: from dialpool2-106.dial.tijd.com ([62.112.11.106]:36226 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S264519AbUHDMHh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 08:07:37 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.8-rc3
Date: Wed, 4 Aug 2004 14:07:20 +0200
User-Agent: KMail/1.6.2
References: <Pine.LNX.4.58.0408031505470.24588@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408031505470.24588@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200408041407.39871.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 04 August 2004 00:09, Linus Torvalds wrote:
> Tons of small fixes all around the tree.
>
> There's an optimized assembly AES implementation for x86 (from Brian
> Gladman), and a number of driver updates, all of which are reasonably
> minor.
>
> It would be good if people only sent serious stuff for a while, and we can
> do a real 2.6.8, ok?
>
> 		Linus

Works like a charm, only one comment:

Mounting my vfat partitions gave me this error:

FAT: codepage or iocharset option didn't specified
     File name can not access proper (mounted as read-only)

which was easily fixed by supplying a iocharset= mount option. But according 
to the man page of mount:

       iocharset=value
              Character set to use for converting between 8 bit characters and
              16 bit Unicode characters. The default is iso8859-1.  Long file-
              names are stored on disk in Unicode format.

the default is iso8859-1. Has this default gone haywire somewhere?

Thanks anyway for another great kernel :)

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBENGKUQQOfidJUwQRApCPAJ9cJC0fZDmRlzmmyJT5372gMK1FmACePEy2
mxQyIW3/SQBA7deQBBwjMX0=
=7cdD
-----END PGP SIGNATURE-----
