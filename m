Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266074AbTLIPw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 10:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266077AbTLIPwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 10:52:55 -0500
Received: from maximus.kcore.de ([213.133.102.235]:46484 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S266074AbTLIPwy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 10:52:54 -0500
From: Oliver Feiler <kiza@gmx.net>
To: David Jez <dave.jez@seznam.cz>, hanasaki <hanasaki@hanaden.com>
Subject: Re: VT82C686  - no sound
Date: Tue, 9 Dec 2003 16:51:27 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <3FD54817.9050402@hanaden.com> <20031209101808.GA18309@stud.fit.vutbr.cz>
In-Reply-To: <20031209101808.GA18309@stud.fit.vutbr.cz>
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey
X-Species: Snow Leopard
X-Operating-System: Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312091651.27677.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 December 2003 11:18, David Jez wrote:

> > == /etc/modules ==
> > snd_via82xx
> > snd_ac97_codec
> > snd_pcm_oss
> > snd_page_alloc
> > snd_pcm
> > snd_timer
> > snd_mixer_oss
> > snd_pcm_oss
> > snd_mpu401_uart
>
>   This is not ALSA modules. If you have configured system for use with
> ALSA, you don't have to use OSS modules. Use ALSA with OSS emulaton
> instead. It should works.

But this _is_ ALSA with the OSS emulation modules loaded (snd_mixer_oss and 
snd_pcm_oss). :)
The OSS driver module is called via82cxxx_audio afaik.

Bye,
Oliver

-- 
Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx[pro].net)>

