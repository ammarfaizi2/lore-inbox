Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVHHRRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVHHRRw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVHHRRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:17:52 -0400
Received: from 213-229-38-18.static.adsl-line.inode.at ([213.229.38.18]:32184
	"HELO home.winischhofer.net") by vger.kernel.org with SMTP
	id S932121AbVHHRRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:17:52 -0400
Message-ID: <42F79415.2020709@winischhofer.net>
Date: Mon, 08 Aug 2005 19:19:17 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/video/sis/ macros for old kernels removal
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Arjan van de Ven wrote:
> On Mon, 2005-08-08 at 17:23 +0200, Jiri Slaby wrote:
> > Jiri Slaby napsal(a):
> >
>>> This patch removes some #ifs, which controls kernel version (2.4 or
>>> like), so the code could be removed with the macros.
>>> linux/version.h inclusions also removed.
>>
>> Sorry, this was bad idea. X includes some of these file, doesn't it?
>
> X can't depend on the version of the kernel anyway; the "version" in
> version.h has no relation with the running kernel anyway (or with the
> version of the kernel that will be used to run the X binaries on)


No good idea anyway. X does, of course, not "include" these files, but
they are reused. I don't want to maintain two different versions of the
files.

Furthermore, I have a quite big sisfb update in the queue which I intend
to submit after 2.6.13 is out. It, amongst others, removes a lot of 2.4
related stuff.

It's best to leave it alone for now.

Thomas

- --
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC95QVzydIRAktyUcRAkrHAJ98HUOIk7LjHQKWhgMVQqqaiH4mQACePYeG
Xl3yGGJeINOsgTT2FOdpQI8=
=aItr
-----END PGP SIGNATURE-----
