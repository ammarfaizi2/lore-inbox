Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbUCSWEM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbUCSWEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:04:11 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:55684 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263036AbUCSWEC (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:04:02 -0500
Message-Id: <200403192203.i2JM3nSN016646@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Robert Love <rml@ximian.com>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de, mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads 
In-Reply-To: Your message of "Thu, 18 Mar 2004 14:24:59 EST."
             <1079637899.6363.8.camel@localhost> 
From: Valdis.Kletnieks@vt.edu
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <s5hlllycgz3.wl@alsa2.suse.de> <20040318110159.321754d8.akpm@osdl.org> <s5hd67ac6r8.wl@alsa2.suse.de>
            <1079637899.6363.8.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-811876149P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 19 Mar 2004 17:03:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-811876149P
Content-Type: text/plain; charset=us-ascii

On Thu, 18 Mar 2004 14:24:59 EST, Robert Love said:
> On Thu, 2004-03-18 at 14:08, Takashi Iwai wrote:
> 
> > oh, sorry, maybe i forgot to tell you that it has been already there
> > :)
> > 
> > 	# echo 1 > /proc/asound/card0/pcm0p/xrun_debug
> > 
> > this will show the stacktrace when a buffer overrun/underrun is
> > detected in the irq handler.  it's not perfect, though.
> 
> Excellent!
> 
> Has this resulted in anything useful?
> 
> With KALLSYMS=y, a lot of users now become intelligent bug testers.
> 
> Eh, except that I do not have that procfs entry on my system..

Is one of these yours?  My machine has 3 (but only one soundcard) ;)

%  find /proc/asound/ -name xrun_debug -ls
  4480    0 -r--r--r--   1 root     root            0 Mar 19 16:00 /proc/asound/card0/pcm1c/xrun_debug
  4470    0 -r--r--r--   1 root     root            0 Mar 19 16:00 /proc/asound/card0/pcm0c/xrun_debug
  4462    0 -r--r--r--   1 root     root            0 Mar 19 16:00 /proc/asound/card0/pcm0p/xrun_debug

(Are these 3 different controls, or 3 places to set the same variable?)

--==_Exmh_-811876149P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAW25FcC3lWbTT17ARAqWpAKC4UMi1rkmlSsMe/TAzroPc9QSqbwCfSegD
mEZD2mSCcjzRhvkv4EpFeEM=
=TFfF
-----END PGP SIGNATURE-----

--==_Exmh_-811876149P--
