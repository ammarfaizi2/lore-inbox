Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752288AbWAFLep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbWAFLep (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 06:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436AbWAFLep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 06:34:45 -0500
Received: from mail.gmx.de ([213.165.64.21]:61157 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752288AbWAFLeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 06:34:44 -0500
X-Authenticated: #4399952
Date: Fri, 6 Jan 2006 12:34:40 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Hannu Savolainen <hannu@opensound.com>
Cc: Edgar Toernig <froese@gmx.de>, Takashi Iwai <tiwai@suse.de>,
       linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
Message-ID: <20060106123440.7359e430@mango.fruits.de>
In-Reply-To: <Pine.LNX.4.61.0601060519450.29362@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de>
	<20060103193736.GG3831@stusta.de>
	<Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
	<mailman.1136368805.14661.linux-kernel2news@redhat.com>
	<20060104030034.6b780485.zaitcev@redhat.com>
	<Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
	<Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
	<Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
	<Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>
	<s5hmziaird8.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi>
	<20060106041421.31579e69.froese@gmx.de>
	<Pine.LNX.4.61.0601060519450.29362@zeus.compusonic.fi>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006 05:33:43 +0200 (EET)
Hannu Savolainen <hannu@opensound.com> wrote:

> Then this is in no way an API issue. Many OSS drivers (including envy24) 
> create separete device files for each input/output channel (or device pair). 
> Applications can chose to open the first device file in for all the 
> channels or any combination of the devices in mono/stereo/n-channel mode.
> 
> All this depends only on the driver implementation. There is nothing API 
> related. Any app can open the devices as usual without paying any 
> attention on the channel allocation (which is done automatically by the 
> driver). xmms (or whatever else consumer app) can open the device and ask 
> for stereo access. Equally well a DAB application can open the device and 
> ask for full 10 output channels (or anything between 1 and 10). No special 
> API features are needed for this.

Hi,

i would find it helpful if you always made it crystal  clear about what
version of OSS you are talking about:

- your proprietary version

- or the free one in the kernel

Mixing these isn't helping the discussion.

Flo

-- 
Palimm Palimm!
http://tapas.affenbande.org
