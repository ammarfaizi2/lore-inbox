Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUJLO0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUJLO0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUJLOYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:24:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22243 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264377AbUJLOYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:24:03 -0400
Date: Mon, 11 Oct 2004 08:36:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Oleksiy <Oleksiy@kharkiv.com.ua>, Pete Zaitcev <zaitcev@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: pl2303/usb-serial driver problem in 2.4.27-pre6
Message-ID: <20041011113609.GB417@logos.cnet>
References: <416A6CF8.5050106@kharkiv.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416A6CF8.5050106@kharkiv.com.ua>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pete, 

I bet this has been caused by your USB changes?

Can you take a look at this please?

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
> 
> i'm using:
> 
> pppd-2.4.2
> Siemens S55 mobile
> USB cable (PL2303 conroller)
> 
> USB drivers:
> 
> ehci_hcd
> uhci.c
> pl2303.c
> 
