Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270929AbTHLQdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270931AbTHLQdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:33:18 -0400
Received: from waste.org ([209.173.204.2]:37764 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S270929AbTHLQdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:33:14 -0400
Date: Tue, 12 Aug 2003 11:33:11 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jon Burgess <mplayer@jburgess.uklinux.net>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Netconsole debugging tool for 2.6
Message-ID: <20030812163311.GL31810@waste.org>
References: <3F38F5EC.2060003@jburgess.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F38F5EC.2060003@jburgess.uklinux.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 03:13:00PM +0100, Jon Burgess wrote:
> Matt Mackall wrote:
> > I've decided to take a stab at resurrecting Ingo's netconsole patch.
> 
> Is this different from the netdump patch which RedHat include in their 
> kernel?
> 
> The RH kernel patch is at
> http://www.kernelnewbies.org/kernels/rh9/SOURCES/linux-2.4.18-netdump.patch

Ahh, so that's what's become of it.

Theirs:
- does crashdumps
- does syslog without levels
- has hooks for receive

Mine:
- works in 2.6
- has non-appalling configuration
- works as a built-in and is available earlier in boot
- does syslog with levels (haven't posted this though)


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
