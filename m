Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWBYMF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWBYMF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 07:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWBYMF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 07:05:57 -0500
Received: from witte.sonytel.be ([80.88.33.193]:47761 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932241AbWBYMF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 07:05:56 -0500
Date: Sat, 25 Feb 2006 12:58:01 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] make INPUT a bool
In-Reply-To: <20060222023121.GB4661@stusta.de>
Message-ID: <Pine.LNX.4.62.0602251255110.18095@pademelon.sonytel.be>
References: <20060214152218.GI10701@stusta.de> <Pine.LNX.4.61.0602141912580.32490@yvahk01.tjqt.qr>
 <20060214182238.GB3513@stusta.de> <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr>
 <20060217163802.GI4422@stusta.de> <93564eb70602191933x2a20ce0m@mail.gmail.com>
 <20060220132832.GF4971@stusta.de> <20060222013410.GH20204@MAIL.13thfloor.at>
 <20060222023121.GB4661@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Adrian Bunk wrote:
> On Wed, Feb 22, 2006 at 02:34:11AM +0100, Herbert Poetzl wrote:
> > On Mon, Feb 20, 2006 at 02:28:32PM +0100, Adrian Bunk wrote:
> > > On Mon, Feb 20, 2006 at 12:33:55PM +0900, Samuel Masham wrote:
> That's not a good solution since EMBEDDED is really only about 
> additional space savings - even if you are an "expert", there's no 
> reason to enable EMBEDDED when building a kernel for systems 
> with > 50 MB RAM.

and

On Fri, 17 Feb 2006, Adrian Bunk wrote:
> And I've already given numbers why CONFIG_EMBEDDED=y and
> CONFIG_MODULES=y at the same time is insane.

But if my m68k box has less than 47.68 MiB RAM, I may want CONFIG_EMBEDDED=y,
and I like to have CONFIG_MODULES=y...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
