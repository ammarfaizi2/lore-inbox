Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbUKVTsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbUKVTsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbUKVTpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:45:47 -0500
Received: from navi.cs.colorado.edu ([128.138.207.240]:18667 "EHLO navi.cx")
	by vger.kernel.org with ESMTP id S263350AbUKVTgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:36:47 -0500
Date: Mon, 22 Nov 2004 12:47:51 -0700
From: Micah Dowty <micah@navi.cx>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: aris@cefetpr.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Force feedback support for uinput
Message-ID: <20041122194751.GA30536@navi.cx>
References: <20041110163751.GA13361@navi.cx> <20041112120852.GA25736@cefetpr.br> <20041121085452.GA26087@navi.cx> <20041122103801.GC24080@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122103801.GC24080@cathedrallabs.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 08:38:01AM -0200, Aristeu Sergio Rozanski Filho wrote:
> > +The uinput driver creates a character device, usually at /dev/uinput, that can
> the default is '/dev/input/uinput'

Really? I haven't tried udev yet (shamefully enough) but with devfs at least
it shows up as /dev/misc/uinput with a symlink at /dev/uinput.

If it really can be either /dev/uinput or /dev/input/uinput, I guess the document
and some of my userspace code needs modifying ;)

--Micah

-- 
Only you can prevent creeping featurism!
