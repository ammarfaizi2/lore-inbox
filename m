Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVBBGFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVBBGFM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 01:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVBBGFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 01:05:11 -0500
Received: from jose.lug.udel.edu ([128.175.60.112]:50358 "HELO
	mail.lug.udel.edu") by vger.kernel.org with SMTP id S261477AbVBBGFF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 01:05:05 -0500
From: ross@lug.udel.edu
Date: Wed, 2 Feb 2005 01:05:05 -0500
To: Timothy Miller <theosib@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA HELP: Crackling and popping noises with via82xx
Message-ID: <20050202060505.GA18324@jose.lug.udel.edu>
References: <9871ee5f05020118343effed7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9871ee5f05020118343effed7@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 09:34:59PM -0500, Timothy Miller wrote:
> Basically, I get random poppling and crackling noises out of my
> speakers.  Sometimes it's silent, and sometimes, it crackles and pops
> for minutes at a time.  It's really disturbing, really, because it
> happens suddenly, sometimes very loudly, and usually when I'm
> concentrating.  :)

The few times I've used the via82xx on my mobo (ASUS KT400, forget the
model number), I've run into some applications that behave similarly.
I never got it randomly - it always happened when an app (ie, xmms)
would open the device and think it was in 44.1kHz when it was really
running at 48kHz.

I do music work on my box, so I've gotta stick with ALSA, but I've
found for common stuff the ALSA interfaces suck pretty bad - nothing
seems to know how to open the devices properly.  As a result, I mostly
use OSS emulation for non-music related things - Frank Barknecht has
info at http://alsa.opensrc.org/index.php?page=DmixPlugin on setting
this up.  Runing all my audio through that fixes the problem, since it
just resample everything to the running rate.

-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37
