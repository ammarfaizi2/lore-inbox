Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbTLIKTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 05:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265123AbTLIKTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 05:19:32 -0500
Received: from eva.fit.vutbr.cz ([147.229.10.14]:16140 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S265118AbTLIKTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 05:19:30 -0500
Date: Tue, 9 Dec 2003 11:18:08 +0100
From: David Jez <dave.jez@seznam.cz>
To: hanasaki <hanasaki@hanaden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VT82C686  - no sound
Message-ID: <20031209101808.GA18309@stud.fit.vutbr.cz>
References: <3FD54817.9050402@hanaden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD54817.9050402@hanaden.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> alsaconf is reporting it cannot be configured.... when the below modules 
> are manually loaded, esd finds the /dev/dsp and runs but there is no 
> sound.  Sound worked fine on 2.4.23
> 
> Any help would be appreciated. thank you
> 
> 00:04.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 
> AC97 Audio Controller (rev 21)
> 
> Running debian sarge with kernel 2.6 test11
> 
> == /etc/modules ==
> snd_via82xx
> snd_ac97_codec
> snd_pcm_oss
> snd_page_alloc
> snd_pcm
> snd_timer
> snd_mixer_oss
> snd_pcm_oss
> snd_mpu401_uart
  This is not ALSA modules. If you have configured system for use with
ALSA, you don't have to use OSS modules. Use ALSA with OSS emulaton
instead. It should works.
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------
