Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVEZUKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVEZUKf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVEZUKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:10:35 -0400
Received: from 1-1-10-11a.has.sth.bostream.se ([82.182.131.18]:2502 "EHLO
	DeepSpaceNine.stesmi.com") by vger.kernel.org with ESMTP
	id S261527AbVEZUK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:10:29 -0400
Message-ID: <42962E0E.2030707@stesmi.com>
Date: Thu, 26 May 2005 22:14:06 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Whittaker <rwhittaker@northwestel.ca>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DHCP options in kernel...
References: <4295EBCB.5030307@northwestel.ca>
In-Reply-To: <4295EBCB.5030307@northwestel.ca>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Richard Whittaker wrote:
> Hiya..
> 
> I'm trying to setup a diskless boot system using a Debian Sarge base,
> and everything's going well, but I've run into one snag... I want the
> DHCP server to dynamically generate hostnames based on MAC addresses,
> and supply those to the clients, and that part's working just fine.
> However, the client (a diskless kernel) isn't taking the hostname and
> applying it to itself... Is there an option that I can pass to the
> kernel that functions like dhcpcd -H, or does something need to be
> kludged at the debian end?...

Just run dhcpcd -H in your init scripts unless there's something
I'm missing?

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFCli4OBrn2kJu9P78RAob4AJ42GpPZLnCOYY7vYb4yMbNYv8pj9wCffLeM
rsnRWP/N3vCQHmmBsur0OXg=
=1TMC
-----END PGP SIGNATURE-----
