Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310501AbSCZKr4>; Tue, 26 Mar 2002 05:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSCZKrt>; Tue, 26 Mar 2002 05:47:49 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:48336 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S310501AbSCZKrd> convert rfc822-to-8bit; Tue, 26 Mar 2002 05:47:33 -0500
Message-Id: <200203261017.g2QAHJEI024182@codeman.linux-systeme.org>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Marc-Christian Petersen <mcp@linux-systeme.de>
Reply-To: mcp@linux-systeme.de
Organization: Linux-Systeme GmbH
To: Samuel Maftoul <maftoul@esrf.fr>
Subject: Re: [ANNOUNCE] Kernel 2.4.18-WOLK3.1
Date: Tue, 26 Mar 2002 11:16:50 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200203251821.g2PIL7oA005522@codeman.linux-systeme.org> <20020326102557.B25079@pcmaftoul.esrf.fr>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 March 2002 10:25, you wrote:

Hi Samuel,

> First of all, I'm happy to see such a Patchset, Thanks.
:-) Thanks that you are using it :)

> you're version name is WOLK in uppercase.
> I would like to ask if there is a naming convention for kernel trees:
> make-kpkg, which is the kernel source/image packager of the debian,
> doesn't support release names in uppercases:
> ---------------------------------------------------------------------
> Lion:/usr/src/linux# make-kpkg
> debian/rules:966: *** Error. The version number 2.4.18-WOLK3.1 is not
> all lowercase. Since the version ends up in the package name of the
> kernel image package, this is a Debian policy violation, and the
> packaging system shall refuse to package the image. . Stop.
> ---------------------------------------------------------------------
> Could you rename your EXTRAVERSION with wolk ? or is it a Debian
> limitation ?
Yes, i know of that limitation of make-kpkg, but i have forgotton to rename 
it for WOLK 3.1. You can do so easily for yourself my editing the patched 
kernel/full wolk kernel File Makefile and look for EXTRAVERSION = -WOLK3.1 
and rename it to -wolk3.1. Its in the 4th line of that File, or, if you 
haven't patched the vanilla at all or want to change it permanently for the 
patchset, edit 99_VERSION, look for +EXTRAVERSION = -WOLK3.1 and rename it 
too.

You want to support Debian Kernel Package of WOLK? I appreciate it :)

-- 
Kind regards
	Marc-Christian Petersen

Linux-Systeme GmbH
Tenderweg 11 45141 Essen
Tel.: +49 201 - 85 85 130 / Mobil: +49 173 - 541 68 09
http://www.linux-systeme.de - http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/408B2D54947750EC
Fingerprint: 8602 69E0 A9C2 A509 8661  2B0B 408B 2D54 9477 50EC
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.
