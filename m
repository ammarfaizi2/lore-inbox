Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270764AbTGVNJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270775AbTGVNJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:09:46 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:64921 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S270764AbTGVNJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:09:40 -0400
Date: Tue, 22 Jul 2003 15:24:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Samuel Flory <sflory@rackable.com>, Charles Lepple <clepple@ghz.cc>,
       michaelm <admin@www0.org>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: Make menuconfig broken
Message-ID: <20030722132415.GA19115@ucw.cz>
References: <20030721163517.GA597@www0.org> <32425.216.12.38.216.1058806931.squirrel@www.ghz.cc> <3F1C8739.2030707@rackable.com> <3F1C888B.8040500@rackable.com> <Pine.LNX.4.44.0307221146120.714-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307221146120.714-100000@serv>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 11:50:47AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 21 Jul 2003, Samuel Flory wrote:
> 
> >   Try this in 2.6.0-test1:
> > rm .config
> > make mrproper
> > make menuconfig
> > 
> >   There is no option for CONFIG_VT, and CONFIG_VT_CONSOLE under 
> > character devices in "make menuconfig.
> 
> Try enabling CONFIG_INPUT.
> 
> Vojtech, how about the patch below? This way CONFIG_VT isn't hidden behind 
> CONFIG_INPUT, but CONFIG_INPUT is selected if needed.

Fine with me.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
