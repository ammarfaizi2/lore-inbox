Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVEQL4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVEQL4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 07:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVEQLz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 07:55:59 -0400
Received: from colin.muc.de ([193.149.48.1]:7439 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261428AbVEQLzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 07:55:46 -0400
Date: 17 May 2005 13:55:41 +0200
Date: Tue, 17 May 2005 13:55:41 +0200
From: Andi Kleen <ak@muc.de>
To: "Sean E. Russell" <ser@germane-software.com>
Cc: Mark Nipper <nipsy@bitgnome.net>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.1[01] freeze on x86_64
Message-ID: <20050517115541.GA99038@muc.de>
References: <423F5152.2010303@ser1.net> <Pine.LNX.4.61.0503221317220.10134@yvahk01.tjqt.qr> <20050322131116.GA15512@king.bitgnome.net> <200505170737.26227.ser@germane-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505170737.26227.ser@germane-software.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mark, are you running the IPW2200 drivers, by any chance?  I'm pretty sure 
> that's what is causing the lock-ups on my end; that, or something in the the 
> kernel's wireless handlers.
> 
> I did hook up an ethernet cable and started doing netconsole traces... only 
> then the problem disappeared!  To make a long story short, the system is 
> entirely stable when running network over ethernet, but when I use the 
> wireless network interface, it eventually locks up.  There are no error 
> messages that I can associate with the wireless device or network traffic.

It might also in theory different timing due to netconsole use,
but it is probably a reasonable lead. I would suggest you contact
the ipw2x00 maintainers.

-Andi
