Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVABUPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVABUPZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVABUPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:15:24 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:49971 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261316AbVABUPI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:15:08 -0500
Date: Sun, 2 Jan 2005 21:16:00 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ingo Oeser <ioe-lkml@axxeo.de>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: kconfig: help includes dependency information
Message-ID: <20050102201600.GA9900@mars.ravnborg.org>
Mail-Followup-To: Ingo Oeser <ioe-lkml@axxeo.de>,
	linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
	Roman Zippel <zippel@linux-m68k.org>
References: <20041230235146.GA9450@mars.ravnborg.org> <20041230235309.GD9450@mars.ravnborg.org> <200501010502.55612.ioe-lkml@axxeo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501010502.55612.ioe-lkml@axxeo.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 01, 2005 at 05:02:55AM +0100, Ingo Oeser wrote:
> 
> I would prefer this information at the END of the help text,
> since it is actually most useful to developers and more advanced users 
> and thus equals in value to the old notice how a module is called.

Thats where it is placed.

> Using the verbose config information and linking to their help texts would 
> make it even more user friendly in my opinion.
verbose config option - please explain what you have in mind here.

> "depends on:" is not really needed, since you usually cannot select any 
> option, where you didn't fulfill the dependencies, AFAICS.
It is sometimes usefull to see what a specific config option is dependent
of. But you are right that it is not visible in menuconfig (today) when
"depends on" is not satisfied.

I'm digging through Petr Baudis patch to link lxdialog with kconfig -
and when finished I may look into extending menuconfig a bit.

	Sam
