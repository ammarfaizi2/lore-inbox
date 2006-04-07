Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWDGVYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWDGVYs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWDGVYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:24:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:20381 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932352AbWDGVYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:24:47 -0400
Date: Fri, 7 Apr 2006 23:24:44 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/POC] multiple CONFIG y/m/n
In-Reply-To: <20060407184400.GA9097@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0604072315530.32445@scrub.home>
References: <20060406224134.0430e827.rdunlap@xenotime.net>
 <20060407184400.GA9097@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Apr 2006, Sam Ravnborg wrote:

> > In doing lots of kernel build testing, I often want to enable all options
> > in a sub-menu and their sub-sub-menus.  Sound is one of the worst^W longest
> > of these, so I chose a shorter (easier) one to practice on:  parport.
> If there is a general need for this we shal enhance kconfig with this.
> We shall not clutter the Kconfig files with this.

I agree.
>From a general perspective I still like to add some basic command line 
tool, which can be used for queries or simple manipulations. Here it also 
would be less a problem to add experimental or distribution specific 
functionality instead of overloading conf.c.
At some point I even had script bindings (via swig), so one could do even 
weirder stuff.

bye, Roman
