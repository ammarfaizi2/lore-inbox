Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbUK3Ai5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbUK3Ai5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUK3Aiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:38:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:44208 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261905AbUK3AgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:36:19 -0500
Date: Mon, 29 Nov 2004 16:35:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kd6pag@qsl.net, linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
Message-Id: <20041129163533.14afa2a5.akpm@osdl.org>
In-Reply-To: <20041120185100.GA1205@elf.ucw.cz>
References: <E1CVYZM-0000Fi-00@penngrove.fdns.net>
	<20041120185100.GA1205@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> > The software suspend issue was long and tedious to narrow down.  Yep, as
> > you suspected, it appears to be specific a driver (or group thereof).  It
> > appears to happen when the sound subsystem is included.  Attached below 
> > is the .config and a 'diff' from the losing one to one which works.
> 
> Okay, this is for the alsa team then. Somewhere between 2.6.10-rc1 and
> 2.6.10-rc2, ALSA started breaking swsusp :-(.

What does "breaking" mean?  The driver fails to suspend the device? 
Scribbles on memory?

Also, John: did those framebuffer problems get fixed?

Thanks.
