Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266468AbUBLOzq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 09:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266477AbUBLOzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 09:55:46 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:11444 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S266468AbUBLOzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 09:55:45 -0500
Date: Thu, 12 Feb 2004 09:47:34 -0500
From: Ben Collins <bcollins@debian.org>
To: walt <wa1ter@myrealbox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.3-rc2 bk]  ieee1394 oops on bootup
Message-ID: <20040212144734.GA639@phunnypharm.org>
References: <fa.fjveksa.v44uhu@ifi.uio.no> <402B92A4.7040703@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402B92A4.7040703@myrealbox.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 06:50:12AM -0800, walt wrote:
> walt wrote:
> >This problem started with the bk changesets from Linus yesterday (11Feb).
> >
> >I get the oops below if Firewire is compiled into the kernel or if the
> >modules are loaded at bootime (I'm using hotplug+udev).  The strange
> >thing is that if I load the Firewire modules by hand after bootup then
> >everything is okay....
> 
> Sorry, I just discovered that this is wrong.  I can load the ieee1394
> module with no errors.  It is only when I load the ohci1394 module
> that the oops occurs -- even after booting.

I've already got a fix for this. Getting ready to post it to the list.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
