Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWIYU1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWIYU1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWIYU1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:27:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44049 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750938AbWIYU1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:27:00 -0400
Date: Mon, 25 Sep 2006 20:26:45 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Takashi Iwai <tiwai@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18: hda_intel: azx_get_response timeout, switching to single_cmd mode...
Message-ID: <20060925202644.GB6278@ucw.cz>
References: <451834D0.40304@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451834D0.40304@goop.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a ThinkPad X60 which uses the Intel 82801G HDA 
> audio chip.  This used to work for me, but lately 
> (sometime during 2.6.18-rcX series) it stopped working - 
> programs trying to use it tend to just block forever 
> waiting for /dev/dsp.

I have x60 here,

> The only obvious symptom is:
> 
>    hda_intel: azx_get_response timeout, switching to 
>    single_cmd mode...
> 

sometimes see this message, too, and sound more or less works for me.
(Using alsa interface, mplayer works ok. mpg123 does not work).


-- 
Thanks for all the (sleeping) penguins.
