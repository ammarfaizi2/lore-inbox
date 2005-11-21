Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVKUBcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVKUBcn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbVKUBcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:32:43 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:38529 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932170AbVKUBcm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:32:42 -0500
Date: Mon, 21 Nov 2005 02:32:41 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Message-ID: <20051121013241.GA7009@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511200018.11791.gene.heskett@verizon.net> <20051121001548.GA6964@linuxtv.org> <200511202007.44600.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511202007.44600.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.247.107
Subject: Re: Linux 2.6.15-rc2
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 08:07:44PM -0500, Gene Heskett wrote:
> On Sunday 20 November 2005 19:15, Johannes Stezenbach wrote:
> >On Sun, Nov 20, 2005 Gene Heskett wrote:
> >> First breakage report, tvtime, blue screen no audio.  Trying slightly
> >> different .config for next build.
> >
> >Probably v4l breakage due to VM changes. For me xawtv overlay works,
> >grabdisplay doesn't (with different cards). This was reported before.
> >
> >> My tuner (OR51132) seems to be
> >> permanently selected in an xconfig screen.  Dunno if thats good or
> >> bad ATM.
> >
> >Works for me in menuconfig. You probably have
> >CONFIG_VIDEO_SAA7134_DVB_ALL_FRONTENDS selected?
> 
> Nope. its off.  Or lets put it this way:
> # grep SAA7134 .config
> # CONFIG_VIDEO_SAA7134 is not set
> 
> The longer string above doesn't exist in my .config, made from the
> 2.6.14.2 .config with a make oldconfig.  Is this a bug in the patchfile?

Maybe you should've included the actual hardware you use in your initial
posting. How about CONFIG_VIDEO_CX88_DVB_ALL_FRONTENDS, or
$ grep DVB_ALL_FRONTENDS .config

Johannes
