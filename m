Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUJLROR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUJLROR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUJLRMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:12:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:4317 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266465AbUJLRKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:10:35 -0400
Date: Tue, 12 Oct 2004 10:10:04 -0700
From: Greg KH <greg@kroah.com>
To: Oleksiy <Oleksiy@kharkiv.com.ua>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: pl2303/usb-serial driver problem in 2.4.27-pre6
Message-ID: <20041012171004.GB11750@kroah.com>
References: <416A6CF8.5050106@kharkiv.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416A6CF8.5050106@kharkiv.com.ua>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 02:22:32PM +0300, Oleksiy wrote:
> Hi all,
> 
> I have a problem using GPRS inet vi my Siemens S55 attached with USB 
> cable since kernel version 2.4.27-pre5, the link is established well, 
> but then no packets get received, looking with tcpdump shows outgoing 
> ping packets and just few per several minutes received back. I'm unable 
> to ping, do nslookup, etc.
> The problem started when i switched from kernel 2.4.26 (linux slackware 
> 10.0) to 2.4.28-pre3. None of ppp otions haven't changed and all the 
> same options were set during kerenel config. So i decided to test all 
> kernels between 2.4.26 and 2.4.28-pre4 (also not working). Link works 
> well in 2.4.27-pre5 and stop working in 2.4.27-pre6. No "strange" 
> messages or errors in the logs. firewall is disabled (ACCEPT for all).

Can you enable CONFIG_DEBUG?

There were no pl2303 driver changes between 2.4.27-pre5 and pre6, so I
don't think it's that driver...

thanks,

greg k-h
