Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUHGFrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUHGFrs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 01:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUHGFrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 01:47:48 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:57005 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266249AbUHGFrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 01:47:41 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O3
From: Lee Revell <rlrevell@joe-job.com>
To: Remon Sijrier <remon@vt.shuis.tudelft.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200408042124.36537.remon@vt.shuis.tudelft.nl>
References: <200408042124.36537.remon@vt.shuis.tudelft.nl>
Content-Type: text/plain
Message-Id: <1091857656.1447.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 07 Aug 2004 01:47:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-04 at 15:24, Remon Sijrier wrote:
> Hello,
> 
> The compilation went fine, but there are some problems I can't solve :-(
> 
> I had to disable both drm (dri) and acpi to get rid from warning messages but 
> still X doesn't start with the following message in it's log file:
> 
> xf86OpenSerial cannot open device /dev/psaux no such device
> 
> This wasn't a problem before. Any help would be appreciated.
> 
> Thanks,
> 
> Remon

/dev/psaux is deprecated.  Use /dev/input/mice.  On Debian, you can do
this with `dpkg-reconfigure xserver-xfree86'.  Otherwise, use your
distro's X configurator, or edit /etc/X11/XF86Config-4 and replace
/dev/psaux with /dev/input/mice.

Lee

