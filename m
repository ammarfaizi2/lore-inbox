Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWIYS7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWIYS7U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWIYS7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:59:20 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:10962 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751483AbWIYS7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:59:19 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode")
Date: Mon, 25 Sep 2006 21:02:17 +0200
User-Agent: KMail/1.9.1
Cc: Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <20060925071338.GD9869@suse.de> <20060925081704.GC2107@elf.ucw.cz>
In-Reply-To: <20060925081704.GC2107@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609252102.17580.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 25 September 2006 10:17, Pavel Machek wrote:
> Hi!
> 
> > From: Stefan Seyfried <seife@suse.de>
> > 
> > Add an ioctl to the userspace swsusp code that enables the usage of the
> > pmops->prepare, pmops->enter and pmops->finish methods (the in-kernel
> > suspend knows these as "platform method"). These are needed on many machines
> > to (among others) speed up resuming by letting the BIOS skip some steps or
> > let my hp nx5000 recognise the correct ac_adapter state after resume again.
> > 
> > Signed-off-by: Stefan Seyfried <seife@suse.de>
> 
> ACK, but please supply documentation patch, too.

I'll update the documentation along with the patch for supporting swap files
in uswsusp.  It's almost ready, but I need to test it for a while before I let
it go.

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
