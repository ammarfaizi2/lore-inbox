Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311566AbSCNJHs>; Thu, 14 Mar 2002 04:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311567AbSCNJHj>; Thu, 14 Mar 2002 04:07:39 -0500
Received: from smtp-sec1.zid.nextra.de ([212.255.127.204]:32016 "EHLO
	smtp-sec1.zid.nextra.de") by vger.kernel.org with ESMTP
	id <S311566AbSCNJH3>; Thu, 14 Mar 2002 04:07:29 -0500
Date: Thu, 14 Mar 2002 10:07:22 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_SOUND_GAMEPORT in 2.5
In-Reply-To: <20020314091915.C31998@ucw.cz>
Message-ID: <Pine.LNX.4.33.0203141004030.15512-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The problem is, that if you don't have anything like a sound-card/gameport
> > at all, CONFIG_SOUND_GAMEPORT still will be YES. Ok, I didn't check in the
> > code, maybe it doesn't add a single byte to the kernel, .config looks a
> > bit confusing, doesn't it?
>
> Yes, it doesn't add anything. It's just a switch that *disables*
> gameport code in sound drivers if no gameport support is selected in the
> kernel.

Sorry, did I get it right - if it is set to "yes", then it DISABLES
gameport code?... Hm... Ok, as long as it doesn't add anything, I better
shut up now, but, seems to me, it does look confusing...

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

