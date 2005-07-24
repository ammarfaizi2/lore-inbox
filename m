Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVGXVcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVGXVcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 17:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVGXVcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 17:32:15 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:46543 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261374AbVGXVa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 17:30:28 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RTC Timezone
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <Pine.LNX.4.61.0507241707140.11580@yvahk01.tjqt.qr>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1Dwo2s-0003M3-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 24 Jul 2005 23:30:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.61.0507241707140.11580@yvahk01.tjqt.qr> you wrote:
> My RTC clock is set to the local timezone. However, when I boot linux using 
> the -b option, to stop by a shell before the bootscripts begin, the clock is 
> exaclty two hours ahead.

The problem is that the clock is correct, but the timezone of your system is
not set yet. You can fix this by running the clock in UTC or not stop the boot
process that early.

Greetings
Bernd
