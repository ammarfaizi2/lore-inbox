Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268849AbUJPUaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268849AbUJPUaY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268856AbUJPUaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 16:30:23 -0400
Received: from cantor.suse.de ([195.135.220.2]:47291 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268849AbUJPUaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 16:30:03 -0400
Date: Sat, 16 Oct 2004 22:29:59 +0200
From: Olaf Hering <olh@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] kconfig: OVERRIDE: save kernel version in .config file
Message-ID: <20041016202959.GA26035@suse.de>
References: <20040917154346.GA15156@suse.de> <20040917102024.50188756.rddunlap@osdl.org> <20040917104334.1b7d7d19.rddunlap@osdl.org> <20041016212859.GC8765@mars.ravnborg.org> <Pine.LNX.4.61.0410162206560.7182@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0410162206560.7182@scrub.home>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Oct 16, Roman Zippel wrote:

> Hi,
> 
> On Sat, 16 Oct 2004, Sam Ravnborg wrote:
> 
> > Applied - but I named it KCONFIG_TIMESTAMP so people would not
> > think that kbuild suddenly stopped checking timestamps.
> 
> That reminds me, I'm not really happy with this patch, it's a hack not a 
> real solution, either we save the timestamp always or not at all, making 
> it dependent on an environment variable is IMO ugly.

The point is: avoid conflicts when 2 people change different parts of
the .config.
Just drop the whole thing, I doubt the timestamp matters much.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
