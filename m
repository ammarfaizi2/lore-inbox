Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTDLUzc (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 16:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTDLUzc (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 16:55:32 -0400
Received: from [195.39.17.254] ([195.39.17.254]:4100 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id S263394AbTDLUzJ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 16:55:09 -0400
Date: Sun, 13 Apr 2003 13:17:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Fixes for ide-disk.c
Message-ID: <20030413111738.GA7409@zaurus.ucw.cz>
References: <1049527877.1865.17.camel@laptop-linux.cunninghams> <1049561200.25700.7.camel@dhcp22.swansea.linux.org.uk> <1049570711.3320.2.camel@laptop-linux.cunninghams> <1049641400.963.18.camel@dhcp22.swansea.linux.org.uk> <20030410183839.GC4293@zaurus.ucw.cz> <1050011724.12930.138.camel@dhcp22.swansea.linux.org.uk> <1050017816.2629.8.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050017816.2629.8.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I hadn't looked at the code yet to see why it's called twice - too busy
> with other things. I did wonder if 
> 
>         device_suspend(4, SUSPEND_NOTIFY);
>         device_suspend(4, SUSPEND_SAVE_STATE);
>         device_suspend(4, SUSPEND_DISABLE);
> 
> might do it, but it's an untested theory.

ide should only care about one of those
levels.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

