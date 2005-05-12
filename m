Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVELDxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVELDxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 23:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVELDxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 23:53:40 -0400
Received: from 1-1-10-11a.has.sth.bostream.se ([82.182.131.18]:9149 "EHLO
	DeepSpaceNine.stesmi.com") by vger.kernel.org with ESMTP
	id S261192AbVELDxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 23:53:34 -0400
Message-ID: <4282D3E1.80303@stesmi.com>
Date: Thu, 12 May 2005 05:56:17 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Rudolf Usselmann <rudi@asics.ws>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Frank Denis (Jedi/Sector One)" <j@pureftpd.org>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: kernel (64bit) 4GB memory support
References: <20041216074905.GA2417@c9x.org> <1103213359.31392.71.camel@cpu0> <Pine.LNX.4.61.0412201246180.12334@montezuma.fsmlabs.com> <1103646195.3652.196.camel@cpu0> <Pine.LNX.4.61.0412210930280.28648@montezuma.fsmlabs.com> <1103647158.3659.199.camel@cpu0> <Pine.LNX.4.61.0412210955130.28648@montezuma.fsmlabs.com> <1115654185.3296.658.camel@cpu10> <20050509200721.GE2297@csclub.uwaterloo.ca> <1115754522.4409.16.camel@cpu10> <20050511142745.GQ2281@csclub.uwaterloo.ca>
In-Reply-To: <20050511142745.GQ2281@csclub.uwaterloo.ca>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Lennart Sorensen wrote:
> On Wed, May 11, 2005 at 02:48:42AM +0700, Rudolf Usselmann wrote:
> 
>>I do see the full 4G. With Fedora Core 2 32bit, I can use all
>>4G as well. All my problems started when I "upgraded" to x86_64 ...
> 
> 
> In 32bit it probably uses the PSE36 extensions or something, which isn't
> the same thing as flat 64bit memory access.  It could just be a matter
> of needing a memory hole somewhere for PCI space or something.  I only
> have 1G in my 64bit machine so I haven't got near these problems.

I don't recall him saying he's changed kernel from the default redhat
kernel in which case he's running the RedHat 4G/4G split kernel and not
using PSE/PAE.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFCgtPhBrn2kJu9P78RAvRnAKCnSbeH+4i/vzAfRYfWJXgFad3fpACfVQdp
JWUmCke6CvQ1mq5Gj4SvkZM=
=50yt
-----END PGP SIGNATURE-----
