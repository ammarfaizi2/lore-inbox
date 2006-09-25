Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWIYIRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWIYIRJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 04:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWIYIRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 04:17:09 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29140 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750736AbWIYIRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 04:17:06 -0400
Date: Mon, 25 Sep 2006 10:17:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode")
Message-ID: <20060925081704.GC2107@elf.ucw.cz>
References: <20060925071338.GD9869@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925071338.GD9869@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Stefan Seyfried <seife@suse.de>
> 
> Add an ioctl to the userspace swsusp code that enables the usage of the
> pmops->prepare, pmops->enter and pmops->finish methods (the in-kernel
> suspend knows these as "platform method"). These are needed on many machines
> to (among others) speed up resuming by letting the BIOS skip some steps or
> let my hp nx5000 recognise the correct ac_adapter state after resume again.
> 
> Signed-off-by: Stefan Seyfried <seife@suse.de>

ACK, but please supply documentation patch, too.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
