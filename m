Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVFCFQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVFCFQJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 01:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVFCFQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 01:16:09 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:20517 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261241AbVFCFQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 01:16:05 -0400
Message-ID: <429FE78C.1080702@suse.com>
Date: Fri, 03 Jun 2005 01:15:56 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: l0rd4gu1@icontrol.com.mx
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: doing a dd to a dbfile
References: <1117673999.28282.2.camel@localhost>  <429F5BB6.90301@suse.com> <1117768588.12719.2.camel@localhost>
In-Reply-To: <1117768588.12719.2.camel@localhost>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ing. Raúl Alvarez Aguileta wrote:
> Hi Jeff
> 
> Thanks for the help, i've published the image at:
> 
> http://egw.servebeer.com/vmlinux.bz2

Ok, thanks.

As a data point, the index (i) [from %r13] used is 0. This is definitely
a problem since the buffers are allocated for the page just previous to
the call of reiserfs_allocate_blocks_for_region(), and the page remains
locked.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCn+eMLPWxlyuTD7IRAo1SAJoDXqGAUChxDErxnn2iYow/LunQVQCfSGSn
HL7ga2+tl+JZztO7kgzOLRA=
=K41t
-----END PGP SIGNATURE-----
