Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTIDXfu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 19:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTIDXfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 19:35:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:48082 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261362AbTIDXfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 19:35:41 -0400
Date: Thu, 4 Sep 2003 16:36:15 -0700
From: Dave Olien <dmo@osdl.org>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bastian@schottelius.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.0] ramdisk rd.o problems with devfs
Message-ID: <20030904233615.GA28952@osdl.org>
References: <20030902111846.GA9257@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902111846.GA9257@schottelius.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually, they seems to appear under /dev/rd.
That's a too bad because DAC960 devices also appear under /dev/rd.
I think this was the case in 2.4 also.  I wonder if there's
a problem with relocating one of them to a different directory.

On Tue, Sep 02, 2003 at 01:18:46PM +0200, Nico Schottelius wrote:
> Hello!
> 
> When using modprobe rd I got no new devices under /dev.
> Shouldn't be /dev/ram/X created?
> Are there any known bugs in 2.6.0 ramdisk, which makes it 
> impossible to boot from initrd?
> Are there changes to the 2.4 initrd?
> 
> Sincerly,
> Nico
> 
> -- 
> quote:   there are two time a day you should do nothing: before 12 and after 12
>          (Nico Schottelius after writin' a very senseless email)
> cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
> pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.new
> url:     http://nerd-hosting.net - domains for nerds (from a nerd)


