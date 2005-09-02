Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbVIBVsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbVIBVsO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbVIBVsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:48:14 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:31499 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1161071AbVIBVsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:48:12 -0400
Message-ID: <4318C893.1000009@tuxrocks.com>
Date: Fri, 02 Sep 2005 15:48:03 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Make the bzImage format self-terminating
References: <4318BD50.5050507@zytor.com> <4318C3F6.6000004@zytor.com>
In-Reply-To: <4318C3F6.6000004@zytor.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

H. Peter Anvin wrote:
> I'm proposing the attached patch to replace Frank Sorenson's
> i386-buildc-write-out-larger-system-size-to-bootsector patch currently
> in -mm.  The goal (presumably) is to make the bzImage format
> self-terminating.
> 
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>

Looks good to me.  Using the 2 additional bytes allows the header to
contain the full system size for a very long time, and your patch
includes documentation and x86_64.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDGMiTaI0dwg4A47wRAghjAJ9p5sElrA0kDpbwmX4kW9N6WoE3TwCg0Slp
yq/DxrzJ32DlG+Scp4I7zDM=
=DKHC
-----END PGP SIGNATURE-----
