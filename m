Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVC2VVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVC2VVk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVC2VVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:21:32 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:43753 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261471AbVC2VSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:18:36 -0500
Subject: Re: [Alsa-devel] Re: 2.6.12-rc1-mm3, sound card lost id
From: Lee Revell <rlrevell@joe-job.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Takashi Iwai <tiwai@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <20050329231345.281e7323.khali@linux-fr.org>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	 <20050326111945.5eb58343.khali@linux-fr.org> <s5hr7hyiqra.wl@alsa2.suse.de>
	 <20050329195721.385717aa.khali@linux-fr.org>
	 <1112127424.5141.7.camel@mindpipe>
	 <20050329224630.069cda56.khali@linux-fr.org>
	 <1112129571.5141.18.camel@mindpipe>
	 <20050329231345.281e7323.khali@linux-fr.org>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 16:18:31 -0500
Message-Id: <1112131111.5386.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 23:13 +0200, Jean Delvare wrote:
> > +	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80271102,
> > +	 .driver = "EMU10K1", .name = "SBLive! Value [CT4832]", 
> > +	 .emu10k1_chip = 1,
> > +	 .ac97_chip = 1} ,
> Unsurprisingly, my card is now named CT4832. I had to edit
> /etc/asound.state manually to get my mixer settings back (with some
> warnings, but I get some sound).
> 
> Not sure I quite see the idea of renaming from "Live", which the user
> will understand, to (I suppose) the exact chip name on the card, while
> the user has certainly no idea what it is. But heh I'm not an ALSA
> developer, there must be a good reason.

Blame Creative.  They have released so many different cards under the
Live! name that it's become meaningless.  There are now two separate
classes of cards marketed as Live! (or Audigy) that don't even use the
same driver (ca0106 and emu10k1x), the hardware isn't even similar.
Unsurprisingly, the user confusion is massive.

The model number is the simplest unique identifier.  This is also what
the "good" Windows drivers for these devices, http://www.kxproject.com,
use.

Lee

