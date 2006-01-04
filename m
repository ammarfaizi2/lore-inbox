Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbWADI74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbWADI74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 03:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbWADI7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 03:59:55 -0500
Received: from [81.2.110.250] ([81.2.110.250]:44260 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751602AbWADI7y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 03:59:54 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl>
References: <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl>
	 <s5hvex1m472.wl%tiwai@suse.de>
	 <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
	 <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl>
	 <20060103231009.GI3831@stusta.de>
	 <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
	 <20060104000344.GJ3831@stusta.de>
	 <Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl>
	 <20060104010123.GK3831@stusta.de>
	 <Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Wed, 04 Jan 2006 08:50:34 +0000
Message-Id: <1136364634.22598.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-04 at 03:51 +0100, Tomasz Kłoczko wrote:
> Be compliant with OSS specyfication allow save many time on applications 
> development level by consume (in good sense) time spend on this 
> applications by *BSD, Solaris and other systems developers (even on not 
> open source applications).

Both Solaris and FreeBSD contain Linux emulation code so in that sense
they admitted 'defeat' long ago.

> valuable functionalities in usable/simpler form for joe-like users .. 
> remember: sound support in Linux isn't for data centers/big-ass-machines :)

And distributions nowdays ship with ALSA by default, which is giving
users far better audio timing behaviour, mixing they want, digital and
analogue 5.1 outputs. OSS really isn't ideal for serious "end user"
applications like video playback

Alan

