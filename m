Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311567AbSCNJM2>; Thu, 14 Mar 2002 04:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311568AbSCNJMS>; Thu, 14 Mar 2002 04:12:18 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:63761 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311567AbSCNJMK>; Thu, 14 Mar 2002 04:12:10 -0500
Date: Thu, 14 Mar 2002 10:12:04 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_SOUND_GAMEPORT in 2.5
Message-ID: <20020314101204.A32577@ucw.cz>
In-Reply-To: <20020314091915.C31998@ucw.cz> <Pine.LNX.4.33.0203141004030.15512-100000@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0203141004030.15512-100000@pcgl.dsa-ac.de>; from gl@dsa-ac.de on Thu, Mar 14, 2002 at 10:07:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 10:07:22AM +0100, Guennadi Liakhovetski wrote:
> > > The problem is, that if you don't have anything like a sound-card/gameport
> > > at all, CONFIG_SOUND_GAMEPORT still will be YES. Ok, I didn't check in the
> > > code, maybe it doesn't add a single byte to the kernel, .config looks a
> > > bit confusing, doesn't it?
> >
> > Yes, it doesn't add anything. It's just a switch that *disables*
> > gameport code in sound drivers if no gameport support is selected in the
> > kernel.
> 
> Sorry, did I get it right - if it is set to "yes", then it DISABLES
> gameport code?... Hm... Ok, as long as it doesn't add anything, I better
> shut up now, but, seems to me, it does look confusing...

No, if it is set to yes, it allows the gameport code in the sound
drivers. If set to no, it disables it. All only if the sound drivers
which have gameport code in them are enabled.

-- 
Vojtech Pavlik
SuSE Labs
