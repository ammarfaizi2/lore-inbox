Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSKRBQJ>; Sun, 17 Nov 2002 20:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSKRBQJ>; Sun, 17 Nov 2002 20:16:09 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:23050 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261286AbSKRBQI>; Sun, 17 Nov 2002 20:16:08 -0500
Date: Sun, 17 Nov 2002 20:23:02 -0500
From: Ben Collins <bcollins@debian.org>
To: Shanti Katta <katta@csee.wvu.edu>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Compiling packages from source on Ultrasparc
Message-ID: <20021118012302.GD544@phunnypharm.org>
References: <1037581211.30240.17.camel@indus.csee.wvu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037581211.30240.17.camel@indus.csee.wvu.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2002 at 08:00:11PM -0500, Shanti Katta wrote:
> Hi,
> I understand that userland is 32-bit on Ultrasparc. I am trying to
> compile user-mode-linux on Ultrasparc, and I guess I need to compile it
> in 32-bit mode for it to run as a normal user-level process. UML make
> use of certain files in asm-{base-arch} during compilation. Now, to
> compile uml in 32-bit mode, I did not include any flags in
> makefiles(like -m64, -mcpu=ultrasparc) that would include 64-bit
> specific asm code.
> My question is that, what difference does it make when I compile UML, in
> a sparc32 shell, as compared to the above process without executing the
> sparc32 shell. I understand that if compiled in sparc32 shell, it
> recognizes the host-arch as "sparc" instead of "sparc64". But other than
> that, does it make any other difference? I am also not sure, which is
> the right method for compiling UML.
> Any pointers will be appreciated.

To compile it as a 32bit app, use the sparc32 wrapper to be safe, or
pass sparc as the target arch for UML.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
