Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbTDKTKp (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbTDKTKp (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:10:45 -0400
Received: from quechua.inka.de ([193.197.184.2]:34719 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261528AbTDKTKn (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 15:10:43 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Debugging hard lockups (hardware?)
In-Reply-To: <200304111808.LAA06725@redhot.rose.hp.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.18-xfs (i686))
Message-Id: <E19446Q-0001lx-00@calista.inka.de>
Date: Fri, 11 Apr 2003 21:22:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200304111808.LAA06725@redhot.rose.hp.com> you wrote:
> Has anyone ever thought about that fact that although the dog might bark
> (printk), klogd may be deaf in some cases?

Yes of course, thats why you need to look at the console (serial or vga).
This can fail also, but the code path in printk is reasonable short that the
chances are good you still get the output.

> I don't know if all x86 hardware has this, but I know that the couple of
> systems I typically use have a small amount of battery backed ram that is
> available for use in the RTC.

Actually you do not need battery backed ram, if the server supports
non-cleared ram on reset.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
