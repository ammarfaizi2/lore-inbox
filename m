Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbUJaQXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbUJaQXB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 11:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbUJaQXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 11:23:01 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:26800 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261254AbUJaQWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 11:22:48 -0500
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Z Smith <plinius@comcast.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41843E10.1040800@comcast.net>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	 <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20041030222720.GA22753@hockin.org>
	 <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1099176319.25194.10.camel@localhost.localdomain>
	 <41843E10.1040800@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099235990.16414.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 31 Oct 2004 15:19:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-31 at 01:21, Z Smith wrote:
> Alan Cox wrote:
> 
> > So if the desktop stuff is annoying you join gnome-love or whatever the
> > kde equivalent is 8)
> 
> Or join me in my effort to limit bloat. Why use an X server
> that uses 15-30 megs of RAM when you can use FBUI which is 25 kilobytes
> of code with very minimal kmallocing?

My X server seems to be running at about 4Mbytes, plus the frame buffer
mappings which make it appear a lot larger. I wouldn't be suprised if
half the 4Mb was pixmap cache too, maybe more.

I've helped write tiny UI kits (take a look at nanogui for example) but
they don't have the flexibility of X.

Alan

