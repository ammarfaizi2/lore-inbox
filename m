Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264670AbUEaPTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbUEaPTe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 11:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264671AbUEaPTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 11:19:33 -0400
Received: from [212.209.10.220] ([212.209.10.220]:31467 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264670AbUEaPTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 11:19:32 -0400
Date: Mon, 31 May 2004 18:14:02 +0200 (CEST)
From: Bjorn Wesen <bjorn.wesen@axis.com>
X-X-Sender: <bjornw@godzilla.se.axis.com>
To: Dan Kegel <dank@kegel.com>
cc: Mikael Starvik <mikael.starvik@axis.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Delete cris architecture?
In-Reply-To: <40BB3751.6060200@kegel.com>
Message-ID: <Pine.LNX.4.33.0405311807550.14955-100000@godzilla.se.axis.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The CRIS architecture is stable and supported by Axis Communications 
officially in 2.4, but the 2.6 port is work-in-progress, thus you could 
expect problems building it from the vanilla kernel source. It works 
in-house on 2.6, but perhaps all patches have not trickled out to the 
official kernel yet (although they should have I think, so it's good that 
you mention stuff like this).

In the meantime, I would recommend using 2.4 if you want to compile a CRIS 
kernel.

Regards

Bjorn W

On Mon, 31 May 2004, Dan Kegel wrote:

> on linux-2.6.6, 'make oldconfig' fails on cris with
> 
> scripts/kconfig/conf -o arch/cris/Kconfig
> arch/cris/Kconfig:158: can't open file "arch/cris/drivers/Kconfig"
> make[1]: *** [oldconfig] Error 1
> 
> This was reported about a year ago on 2.6.0-test2:	
> http://mhonarc.axis.se/dev-etrax/msg03456.html
> but it seems nothing has been done about it.
> 
> Since step 1 of building a linux kernel for cris seems to have
> been dead in the water for almost a year with no
> action from the port's maintainer, perhaps the port
> should be deleted from the main kernel tree.
> 
> Or perhaps the maintainer could submit a fix.  His choice :-)
> - Dan
> 
> 

