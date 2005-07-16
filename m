Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVGPIWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVGPIWX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 04:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVGPIWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 04:22:23 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:39573 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261605AbVGPIWU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 04:22:20 -0400
Date: Sat, 16 Jul 2005 09:54:50 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kconfig: lxdialog: Enable UTF8
Message-ID: <20050716095450.GC8064@mars.ravnborg.org>
References: <1121273456.2975.3.camel@spirit> <1121274450.2975.12.camel@spirit> <Pine.LNX.4.61.0507131916060.9023@yvahk01.tjqt.qr> <Pine.LNX.4.58.0507140117210.18332@ppg_penguin.kenmoffat.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507140117210.18332@ppg_penguin.kenmoffat.uklinux.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> OK, I'll bite - non utf8 here, and no libncursesw : a quick google
> suggests I can get it if I recompile ncurses with --enable-widec, but
> why would I want to do that ?
Could you try if specifying both libraries works for you. the 'w'
version first. Then we can use the 'w' version when available but
fall-back to the normal case if not.

	Sam
