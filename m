Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWELTTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWELTTa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 15:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWELTTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 15:19:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42652 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751358AbWELTT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 15:19:29 -0400
Date: Fri, 12 May 2006 12:18:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [GIT PATCH] I2C bugfixes for 2.6.17-rc4 - resend
In-Reply-To: <20060512190332.GA22627@kroah.com>
Message-ID: <Pine.LNX.4.64.0605121216540.3866@g5.osdl.org>
References: <20060512190332.GA22627@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, Greg KH wrote:
>
> Here are some i2c bug fixes for a single driver against your current git
> tree.  They all have been in the -mm tree for a few weeks.

Pulled. 

However, please fix your scripts:

> Please pull from:
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/

Nobody should use "rsync:", it's just more pain for everybody these days. 
If you use rsync, and miss an object, because the mirroring was 
incomplete, you'll never know, you'll just have a strange corrupted 
archive.

Use rsync if you mirror things, but not for git.

So please make that read "git://git.kernel.org/.." instead. 

		Linus
