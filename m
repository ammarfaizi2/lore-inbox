Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWCaPWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWCaPWh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 10:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWCaPWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 10:22:37 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:31240 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751383AbWCaPWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 10:22:36 -0500
Date: Fri, 31 Mar 2006 17:22:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Spurious rebuilds of raid6 and drivers/media/video in 2.6.16
Message-ID: <20060331152226.GB8992@mars.ravnborg.org>
References: <442BC74B.7060305@gmx.net> <20060330202208.GA14016@mars.ravnborg.org> <442C4469.1040408@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442C4469.1040408@gmx.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 10:49:45PM +0200, Carl-Daniel Hailfinger wrote:
 
> Well, it would cause less confusion. It seems that ~90% of rebuilt files
> are due to the following makefiles where full paths to includes are
> specified:
> ./drivers/media/video/cx88/Makefile
> ./drivers/media/video/Makefile
> ./drivers/media/video/cx25840/Makefile
> ./drivers/media/video/saa7134/Makefile
> ./drivers/media/video/em28xx/Makefile
> 
> Any objections to fix these?

Care to send a path - then I will include it with next kbuild update.

	Sam
