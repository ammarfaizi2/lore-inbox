Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263046AbVCKBM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbVCKBM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 20:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVCKBMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 20:12:40 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:38188 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263043AbVCKBMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 20:12:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=s4OjXyRhmmRNJzntPH/rLCHn8EV7mtBU6JIfnuaUJns9Mm95PkqE6mkSkhhxo4Ib6rMyajPBRe1buASaTCyzXPJ3ESqMSEZujjhtpMWgtwqDmffZyzq8tyFkuXbUMqn2Em+rhugl7DuDIrsPf/Oy8B7CojOXJe/WZ4ftZg9FOOI=
Message-ID: <21d7e99705031017124f1e7551@mail.gmail.com>
Date: Fri, 11 Mar 2005 12:12:09 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Christian Henz <christian.henz@gmail.com>
Subject: Re: 2.6.11-mm2 + Radeon crash
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <493984f050309121212541d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <493984f050309121212541d8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> When I try to start X, my machine reboots. The screen goes dark as
> usual when setting the video mode, but then I get a beep and I'm
> greeted with the BIOS boot messages. This happened 4/5 times i've
> tried, and once the video mode was actually set (at least I saw the
> usual X b/w pattern with some random framebuffer garbage), the machine
> didn't reboot but after that nothing happened. My keyboard was still
> responsive (ie NumLock LED would still go on/off), but i could neither
> kill X with CTRL-ALT-BACKSPACE nor could i switch back to console, so
> I ended up pressing reset.
> 
> After the crashes I booted with a rescue CD to examine the logs, but I
> could not find any obvious errors.
> 
> Everything works nicely on 2.6.10 and earlier kernels. I'm in the
> process of building 2.6.11.2 to see if the crash occurs there.
> 
> Here is some info on my system:
> 
> I've got an Athlon 1000C on a VIA KT133 chipset and a Radeon 7200 (the
> original Radeon with 32MB SDR RAM). I'm running Debian/sid.
> 

A copy of /var/log/XFree86.0.log and a copy of dmesg and copy of your
.config if you could .. main things of interest whether you have fb
drivers and drm drivers..

Dave.
