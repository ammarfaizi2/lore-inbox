Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTKCUGp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 15:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbTKCUGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 15:06:45 -0500
Received: from mout1.freenet.de ([194.97.50.132]:8396 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S263101AbTKCUGl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 15:06:41 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] [2.6.0-test9 ALSA] ALSA-OSS-emulation unable to register
Date: Mon, 3 Nov 2003 21:06:06 +0100
User-Agent: KMail/1.5.4
References: <200311021458.59759.mbuesch@freenet.de> <s5hu15ltgb5.wl@alsa2.suse.de>
In-Reply-To: <s5hu15ltgb5.wl@alsa2.suse.de>
Cc: alsa-devel@alsa-project.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311032106.28125.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 03 November 2003 20:14, you wrote:
> > CONFIG_SOUND_BT878=y
>
>   ^^^^^^^^^^^^^^^^^^^^
> this conflicts with ALSA.  try to pass the index parameter via boot
> option of snd-ens1371.

Thanks for your suggestion, but it doesn't work.
Still displays
ALSA sound/core/oss/pcm_oss.c:2353: unable to register OSS PCM device 0:0
Is there some other way to make bttv-audio and
ALSA-ens1371 working both? Would be cool if I
could use both at the same time. :)

> it's already fixed on the ALSA cvs version.

ok.

> ciao,
>
> --
> Takashi Iwai <tiwai@suse.de>		ALSA Developer - www.alsa-project.org

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/prVDoxoigfggmSgRAm/zAJ9nwkcRvzM2/w2EgYpbSZL0sZxoegCfYDBu
Oq5ZWs+LPXRF0iw3MfyKySI=
=Fg8x
-----END PGP SIGNATURE-----

