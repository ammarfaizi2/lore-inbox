Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbULWHe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbULWHe0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 02:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbULWHe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 02:34:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:53957 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261172AbULWHeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 02:34:23 -0500
Subject: Re: Radeonfb driver ignores video= when panel detected
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Erich Schubert <erich@debian.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041223021949.GA16681@wintermute.xmldesign.de>
References: <20041223021949.GA16681@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Thu, 23 Dec 2004 08:33:36 +0100
Message-Id: <1103787216.29975.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-23 at 03:19 +0100, Erich Schubert wrote:
> Hi,
> both radeon drivers will ignore the command line options "video=" when
> they detect a TFT panel. They will always use 8 bit color depth then.
> 
> I have a Thinkpad A31p with Radeon Mobility graphics.
> Since I'd like to try out bootsplash/gensplash I'd like to run 16 bit
> color depth. I needed to change this in the kernel
> (in drivers/video/radeonfb.c: radeon_update_default_var(),
> drivers/video/aty/radeon_monitor.c: struct ... radeonfb_default_var)
> because the video= command line option that works fine on other boxes
> with radeons I have doesn't work.
> 
> Did I miss some other option?

No, you didn't, it's a problem that I'll fix after 2.6.10

Ben.


