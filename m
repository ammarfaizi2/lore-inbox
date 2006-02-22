Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161239AbWBVBeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161239AbWBVBeO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 20:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161237AbWBVBeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 20:34:14 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:2187 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1161239AbWBVBeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 20:34:12 -0500
Date: Wed, 22 Feb 2006 02:34:11 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Adrian Bunk <bunk@stusta.de>
Cc: Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060222013410.GH20204@MAIL.13thfloor.at>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Samuel Masham <samuel.masham@gmail.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
	Andrew Morton <akpm@osdl.org>
References: <20060214152218.GI10701@stusta.de> <Pine.LNX.4.61.0602141912580.32490@yvahk01.tjqt.qr> <20060214182238.GB3513@stusta.de> <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr> <20060217163802.GI4422@stusta.de> <93564eb70602191933x2a20ce0m@mail.gmail.com> <20060220132832.GF4971@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220132832.GF4971@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 02:28:32PM +0100, Adrian Bunk wrote:
> On Mon, Feb 20, 2006 at 12:33:55PM +0900, Samuel Masham wrote:
> 
> > Hi Adrian,
> 
> Hi Samuel,
> 
> > > And I've already given numbers why CONFIG_EMBEDDED=y and
> > > CONFIG_MODULES=y at the same time is insane.
> > 
> > >From your numbers this sounds true ... but actually you might want the
> > modules to delay the init of the various hardware bits...
> > 
> > Sometime boot-time is king and you just try and get back as much of
> > the size costs as it takes...
> 
> this is irrelevant since CONFIG_INPUT alone does not init any hardware.
> 
> > I think for EMBEDDED and MODULES is actually a very common case ... if
> > somewhat odd.
> 
> You are misunderstanding EMBEDDED.

well, I suggested the following (or a similar)
change some time ago (unfortunately I could not
find it in the lkml archives, so it might have
been lost)

http://vserver.13thfloor.at/Stuff/embedded_to_expert.txt

best,
Herbert

> It does _not_ mean "this is an embedded device".
> It does mean "offer additional options for additional space savings".
> 
> For an embedded system with relaxed space limits, EMBEDDED=n is the 
> right choice.
> 
> > Samuel
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
