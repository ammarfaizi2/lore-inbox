Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbUK3ODO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUK3ODO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 09:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUK3ODO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 09:03:14 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:50934 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S262078AbUK3ODM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 09:03:12 -0500
Date: Tue, 30 Nov 2004 15:03:10 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/via-rhine: convert MODULE_PARM to module_param
Message-ID: <20041130140309.GA6568@k3.hellgate.ch>
References: <Pine.LNX.4.61.0411300053190.3432@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411300053190.3432@dragon.hygekrogen.localhost>
X-Operating-System: Linux 2.6.10-rc2-bk11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004 00:58:58 +0100, Jesper Juhl wrote:
> These warnings told me that it was time to move to module_param() :)
> 
> drivers/net/via-rhine.c:229: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/via-rhine.c:230: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/via-rhine.c:231: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> 
> So I made this small patch to do so.
> Compile and boot tested on my box, and it seems to work just fine, the 
> module works perfectly with my via-rhine card, and the parameters are 
> exposed through sysfs as expected : 

IIRC Jeff has already queued such a patch for 2.6.11. Thanks, though.

Roger
