Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263574AbRFXTiL>; Sun, 24 Jun 2001 15:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264298AbRFXTiB>; Sun, 24 Jun 2001 15:38:01 -0400
Received: from topaz.opeie.usm.edu ([131.95.45.17]:24704 "HELO
	topaz.opeie.usm.edu") by vger.kernel.org with SMTP
	id <S263574AbRFXThr>; Sun, 24 Jun 2001 15:37:47 -0400
Date: Sun, 24 Jun 2001 14:37:46 -0500 (CDT)
From: Jonathans Test account <jonathan@topaz.opeie.usm.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jakob Borg <jakob@borg.pp.se>, <linux-kernel@vger.kernel.org>
Subject: Re: SMP+USB still crashes in 2.4.6-pre5
In-Reply-To: <E15E9NV-0008EE-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.32.0106241428530.14985-100000@topaz.opeie.usm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2001, Alan Cox wrote:

> > Just wanted people to know that the same problem I reported about 2.4.4 a
> > while back is still present in 2.4.6-pre6 (hard crash when doing "cat
> > whatever > /dev/dsp1" where /dev/dsp1 is an external USB audio device, where
> > "hard crash" means a freeze followed by "wait on irq" message as reported
> > earlier).
>
> Does this happen on 2.4.5-ac kernel as well ?
>

The crash problem seems to also affect usb-storage devices.  Hard lockups
on an SMP machine under 2.4.4, 2.4.5 and 2.4.6pre3.  Dropped back to 2.4.3
and all is well.  Haven't tried on UP or the -ac kernels.  Have been
waiting to see if anyone saw this elsewhere as I know that usb-storage
still has some "issues".  :-)

--
-Jonathan


