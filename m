Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWATNRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWATNRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 08:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWATNRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 08:17:19 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55228 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750941AbWATNRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 08:17:19 -0500
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a
	slightly	different	approach
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz
In-Reply-To: <s5hd5in9p5v.wl%tiwai@suse.de>
References: <20060119174600.GT19398@stusta.de>
	 <1137694944.32195.1.camel@mindpipe> <20060119182859.GW19398@stusta.de>
	 <1137696885.32195.12.camel@mindpipe> <s5hk6cw9h07.wl%tiwai@suse.de>
	 <1137697269.32195.14.camel@mindpipe>
	 <1137708573.8471.65.camel@localhost.localdomain>
	 <s5hd5in9p5v.wl%tiwai@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Jan 2006 13:14:58 +0000
Message-Id: <1137762898.24161.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-01-20 at 11:20 +0100, Takashi Iwai wrote:
> BTW, I remember that there was a driver for native geode audio support
> at the time of ALSA 0.5.x or earlier.  I must have the code somewhere
> in my storage.  The porting would be much much harder than kaulha (sb 
> emulation), though.

The two drivers cover different versions of the Kahlua firmware. VSA1
was the original (at least AFAIK) firmware block. It provides SB16
emulation but has no hooks for drivers to 'take over' properly as you
really want to hook into SMI. VSA2 (the next gen firmware) had various
changes and differences and Cyrix long ago released a rather icky but
working 'native' driver for that.

I have the Cyrix public and most of the earlier NDA documentation if
there are questions but I can't redistribute it.

Alan

