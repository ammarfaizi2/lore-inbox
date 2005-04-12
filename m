Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVDLPWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVDLPWw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVDLPSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:18:55 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:60690 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S262469AbVDLPQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 11:16:55 -0400
Message-ID: <425BE64B.7040801@tuxrocks.com>
Date: Tue, 12 Apr 2005 09:16:27 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Miklos Szeredi <miklos@szeredi.hu>, dan@debian.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411214123.GF32535@mail.shareable.org> <E1DLEby-00013d-00@dorka.pomaz.szeredi.hu> <20050412143347.GC10995@mail.shareable.org>
In-Reply-To: <20050412143347.GC10995@mail.shareable.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jamie Lokier wrote:
> That does not make sense.
> 
> Are you saying you cannot trust your own sshfs userspace daemon?

The user who wrote the userspace code may be able to, but the system
shouldn't trust the userspace daemon.  Permissions will be enforced by
the ssh server.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCW+ZLaI0dwg4A47wRAnDVAKCb2Hk39ouYkjEDgTlz+RTsPsAn5QCgpKvZ
rfYjOi+x6+RSie+t8GIxX74=
=qShM
-----END PGP SIGNATURE-----
