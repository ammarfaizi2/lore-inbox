Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262773AbULQIva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbULQIva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 03:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbULQIva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 03:51:30 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:15249 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262773AbULQIvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 03:51:14 -0500
Date: Fri, 17 Dec 2004 03:51:11 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Magic Number for New File system
In-reply-to: <6E1F4DB94568BB4AA8A30083E67378924BB67C@iiex2ku01.agere.com>
To: "Bhattiprolu, Ravikumar (Ravikumar)" <ravikb@agere.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <41C29DFF.9060803@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <6E1F4DB94568BB4AA8A30083E67378924BB67C@iiex2ku01.agere.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bhattiprolu, Ravikumar (Ravikumar) wrote:
> Hi All,
> 
> We are planning to write a new file system for our requirements. Is
> there any standard way to allocate a magic number for this new file
> system?

Have a cat walk across your numpad.  The value is pretty meaningless
other than as a unique identifier for your fstype. See statfs(2) for a
list of known MAGIC numbers.

> Also how to go about writing the new file system?
> 

For a block device backed fs, see fs/minix/* for a simple enough
example.  Another good example for a much simpler fs is fs/ramfs/inode.c

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBwp3/dQs4kOxk3/MRAnR0AJ4vOWqcG6L192xmsaO3w03Vc5qQhACbBthn
IDjz1oO7q0mofmP1uuitv/E=
=u+W+
-----END PGP SIGNATURE-----
