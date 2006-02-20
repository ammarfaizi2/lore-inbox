Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWBTAnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWBTAnS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWBTAnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:43:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50062 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751153AbWBTAnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:43:17 -0500
Date: Mon, 20 Feb 2006 01:42:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Nick Warne <nick@linicks.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, tiwai@suse.de, ghrt@dial.kappa.ro,
       perex@suse.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: No sound from SB live!
Message-ID: <20060220004249.GJ15608@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz> <20060219214702.GM15311@elf.ucw.cz> <1140385837.2733.394.camel@mindpipe> <200602192323.08169.s0348365@sms.ed.ac.uk> <1140391929.2733.430.camel@mindpipe> <20060219234644.GD15608@elf.ucw.cz> <1140393222.2733.438.camel@mindpipe> <20060220002628.GG15608@elf.ucw.cz> <1140395432.2733.447.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140395432.2733.447.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 19-02-06 19:30:32, Lee Revell wrote:
> On Mon, 2006-02-20 at 01:26 +0100, Pavel Machek wrote:
> > ...but if I launch plain old aumix, I should be able to unmute it and
> > use normally... and that is not the case :-(. 
> 
> Do you have a "libasound2"?

Yes:

root@hobit:~# apt-cache show libasound2
Package: libasound2
Priority: optional
Section: libs
Installed-Size: 1052
Maintainer: Debian ALSA Maintainers
<pkg-alsa-devel@lists.alioth.debian.org>
Architecture: i386
Source: alsa-lib
Version: 1.0.10-2
Depends: libc6 (>= 2.3.5-1)
Suggests: libasound2-plugins (>= 1.0.9)
Conflicts: libasound2-plugins (<< 1.0.9)
Filename: pool/main/a/alsa-lib/libasound2_1.0.10-2_i386.deb
Size: 309306
MD5sum: ab533c9ae6537af36652bf7d88a7f129
Description: ALSA library
 This package contains the ALSA library and its standard
 plugins.
 .
 ALSA is the Advanced Linux Sound Architecture.
Tag: devel::library, role::sw:shlib, works-with::audio

root@hobit:~# apt-get install libasound2
Reading package lists... Done
Building dependency tree... Done
libasound2 is already the newest version.
0 upgraded, 0 newly installed, 0 to remove and 605 not upgraded.
root@hobit:~#

[Lost in the maze of alsa libraries, all alike.]
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
