Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbTADXdE>; Sat, 4 Jan 2003 18:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTADXdE>; Sat, 4 Jan 2003 18:33:04 -0500
Received: from main.gmane.org ([80.91.224.249]:16038 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261742AbTADXdC>;
	Sat, 4 Jan 2003 18:33:02 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Steven Barnhart" <sbarn03@softhome.net>
Subject: Re: 2.5.54-mm3
Date: Sat, 04 Jan 2003 18:41:19 -0500
Message-ID: <pan.2003.01.04.23.41.14.859710@softhome.net>
References: <3E16A2B6.A741AE17@digeo.com> <pan.2003.01.04.15.47.43.915841@softhome.net> <3E174FBB.9065575A@digeo.com> <002401c2b441$4e03eff0$18df9641@steven> <3E17644D.59E3F205@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.0 (The whole remains beautiful)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Jan 2003 14:46:37 +0000, Andrew Morton wrote:

> Your .config was not attached.
> 
> There is a devfs mounting problem in 2.5.54.  If you're using devfs
> you may find that
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.54/2.5.54-mm3/broken-out/devfs-mount-fix.patch
> will help

.config is now attached and no, I am not using devfs.

> The device node exists in /dev.  It sounds like no kernel driver
> has registered itself against tht node's major/minor.   Make really
> sure that you have compiled the appropriate driver for your hardware;
> things may have changed.  All else fails, send lspci and dmesg output
> to this list and/or davej@codemonkey.org.uk

I also attached the dmesg output from 2.5.54. Hope that helps. Sometime
tonight/tomorrow I will reboot 2.5 and attempt to get the lspci output for
the list.

Steven



