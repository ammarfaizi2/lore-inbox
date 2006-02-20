Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWBTN2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWBTN2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWBTN2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:28:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15367 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030210AbWBTN2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:28:35 -0500
Date: Mon, 20 Feb 2006 14:28:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Samuel Masham <samuel.masham@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060220132832.GF4971@stusta.de>
References: <20060214152218.GI10701@stusta.de> <Pine.LNX.4.61.0602141912580.32490@yvahk01.tjqt.qr> <20060214182238.GB3513@stusta.de> <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr> <20060217163802.GI4422@stusta.de> <93564eb70602191933x2a20ce0m@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93564eb70602191933x2a20ce0m@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 12:33:55PM +0900, Samuel Masham wrote:

> Hi Adrian,

Hi Samuel,

> > And I've already given numbers why CONFIG_EMBEDDED=y and
> > CONFIG_MODULES=y at the same time is insane.
> 
> >From your numbers this sounds true ... but actually you might want the
> modules to delay the init of the various hardware bits...
> 
> Sometime boot-time is king and you just try and get back as much of
> the size costs as it takes...

this is irrelevant since CONFIG_INPUT alone does not init any hardware.

> I think for EMBEDDED and MODULES is actually a very common case ... if
> somewhat odd.

You are misunderstanding EMBEDDED.

It does _not_ mean "this is an embedded device".
It does mean "offer additional options for additional space savings".

For an embedded system with relaxed space limits, EMBEDDED=n is the 
right choice.

> Samuel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

