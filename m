Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVAJCQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVAJCQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 21:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVAJCQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 21:16:27 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:6596 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262052AbVAJCQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 21:16:20 -0500
Message-ID: <41E1E57A.7060902@comcast.net>
Date: Sun, 09 Jan 2005 21:16:26 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, znmeb@cesmail.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: starting with 2.7
References: <1697129508.20050102210332@dns.toxicfilms.tv>	 <41DD9968.7070004@comcast.net>	 <1105045853.17176.273.camel@localhost.localdomain>	 <1105115671.12371.38.camel@DreamGate> <41DEC5F1.9070205@comcast.net>	 <1105237910.11255.92.camel@DreamGate> <41E0A032.5050106@comcast.net>	 <1105278618.12054.37.camel@localhost.localdomain>	 <41E1CCB7.4030302@comcast.net> <21d7e99705010917281c6634b8@mail.gmail.com>
In-Reply-To: <21d7e99705010917281c6634b8@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Dave Airlie wrote:
|>And what 3rd party hardware vendor wants to waste their resources by
|>repeting smaller versions of the one-time cost of driver writing over
|>and over to accomodate linux, when they can't even accomodate all
|>versions due to special patches some people have?  So far there's been a
|>rediculous but visible trend of hardware vendors to hold their source
|>closed.
|
|
| I do wonder would open source kernel drivers to work with a closed
| source user space application be accepted into the mainline kernel...
| say for example Nvidia or VMware GPL'ed their lower layer kernel
| interfaces but kept their userspace (X driver and VMware) closed
| source which is perfectly acceptable from a license point of view..
| would Linus/Andrew accept the nvidia lowlevel into the kernel, if not
| then it would be idealogical not licensing issues which would make the
| argument for having a stable module interface better :-)
|
| It would be interesting to find out .. and you are right there is
| little point in arguing this at this stage, closed source drivers are
| evil.
|

I believe closed source drivers are an acceptable evil for two cases:

- - We do not have an open source alteranive yet, and so we need one to
use while that's being developed
- - The hardware is obscure and nobody cares enough to write a driver anyway

open source drivers are better becaus I can just recompile them for new
hardware.  Get a PPC?  Have a USB cam?  Rebuild the kernel for PPC with
OSS drivers.  Can't do that with binaries.  Can't security audit the
source code of binaries either.  :)

| Dave.
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB4eV5hDd4aOud5P8RAnZoAJ9sVMoZTK1HW0RmRtA/OGdmphYTLQCeNtNO
+UvNm8WfPeUj1h90nkAjlZo=
=65kw
-----END PGP SIGNATURE-----
