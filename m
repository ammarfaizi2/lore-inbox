Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUASOXm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 09:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUASOXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 09:23:41 -0500
Received: from openoffice.demon.nl ([212.238.150.237]:28947 "EHLO
	sahara.openoffice.nl") by vger.kernel.org with ESMTP
	id S265125AbUASOXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 09:23:14 -0500
Date: Mon, 19 Jan 2004 15:23:10 +0100
From: Valentijn Sessink <linux-kernel-1074509192@mail.v.sessink.nl>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard crash in IPsec
Message-ID: <20040119142310.GB2991@openoffice.nl>
References: <20040119104854.GA2991@openoffice.nl> <Xine.LNX.4.44.0401190835550.32548-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0401190835550.32548-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.3.28i
X-Message-Flag: Open Office - Linux for the desktop
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello James,

At Mon, Jan 19, 2004 at 08:36:57AM -0500, James Morris wrote:
> > 2.6.0/IPsec crashes, fully reproducable. Verified with 2.6.1.
> Could you please verify if this still happens with Netfilter and SELinux 
> disabled at compile time?

It crashes as well, same "Fatal exception in interrupt" behaviour.

I disabled NETFILTER and recompiled (the config_security option was off in
the original setup already):
# CONFIG_NETFILTER is not set
# CONFIG_SECURITY is not set

Crash! I made a picture (sorry, no serial connection here) but unfortunately
the cable to my camera is at home, so if you need the information, you'll
have to wait. However, I guess the problem is easily reproducable. I posted
my .config file at http://valentijn.sessink.nl/temp/config-2.6.1-yangtse-isdn
(this being the config with netfilter, the one that's normally running).

The other end is running 2.6.1 as well, config is config-2.6.1-router

Please note that the config file that causes the crash is wrong, so a
documentation item that says "the Linux kernel is programmed to commit
suicide on brain dead IPsec configurations" will do ;-)

Best regards,

Valentijn
-- 
http://www.openoffice.nl/   Open Office - Linux Office Solutions
Valentijn Sessink  valentyn+sessink@nospam.openoffice.nl
