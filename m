Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265954AbTF3WnA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 18:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbTF3WnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 18:43:00 -0400
Received: from snoopy.pacific.net.au ([61.8.0.36]:52956 "EHLO
	snoopy.pacific.net.au") by vger.kernel.org with ESMTP
	id S265938AbTF3Wm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 18:42:58 -0400
Date: Mon, 30 Jun 2003 21:52:19 +1000
From: CaT <cat@zip.com.au>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
Subject: Re: Realtek ALC650E support in 2.[45]?
Message-ID: <20030630115219.GC385@zip.com.au>
References: <20030630084943.GB385@zip.com.au> <s5hznjzlw55.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hznjzlw55.wl@alsa2.suse.de>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 12:03:50PM +0200, Takashi Iwai wrote:
> At Mon, 30 Jun 2003 18:49:43 +1000,
> CaT wrote:
> > Anyways, does it support it? I'd prefer fully OS driver support and 
> > don't mind using patches but prefer to be able to compile the driver
> > into the kernel as I like the lack of messyness that comes with
> > monolithic kernels.
> 
> ALC650(E) is the AC97 codec chip.  There must be an audio core in
> addition, most likely Intel ICH chips or VIA 82xx chips.  Both are
> supported by ALSA, snd-intel8x0 and snd-via8xx drivers, respectively.
> On OSS, they are i810_audio and via82cxxx_audio drivers.
> 
> ALC650E is a revision E of ALC650, which has some minor extensions
> (like S/PDIF support) but mostly identical with ALC650. 
> So both should work.

Aha. Ok. What about with an Nvidia2 backend (MCP-T) to all this?

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://www.toledoblade.com/apps/pbcs.dll/artikkel?SearchID=73139162287496&Avis=TO&Dato=20030624&Kategori=NEWS28&Lopenr=106240111&Ref=AR
