Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbUK1MXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbUK1MXs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 07:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUK1MXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 07:23:48 -0500
Received: from quechua.inka.de ([193.197.184.2]:17361 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261448AbUK1MXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 07:23:47 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
Organization: Deban GNU/Linux Homesite
In-Reply-To: <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CYO5h-0006qc-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 28 Nov 2004 13:23:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu> you wrote:
> You misunderstand the motivation.  This is to get/set small compact
> parameters, not huge structures or big data.  Think get/setsockopt().

I understood it quite well. Looks like sys_sysctl to me.

But dont call it a ioctl replacement, since the stuff which causes most
problems will not be handled via that, but more with solutions like netlink.

Greetings
Bernd
