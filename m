Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVDQTsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVDQTsA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 15:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVDQTsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 15:48:00 -0400
Received: from quechua.inka.de ([193.197.184.2]:57035 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261438AbVDQTr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 15:47:57 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Why Ext2/3 needs immutable attribute?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <4ae3c140504170912b36e9b1@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DNFkJ-0006SI-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 17 Apr 2005 21:47:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4ae3c140504170912b36e9b1@mail.gmail.com> you wrote:
> Yes. I know,  with immutable,  even root cannot modify sensitive
> files. What I am curious is if an intruder has root access, he may
> have many ways to turn off the immutable protection and modify files. 

If you secure your system correctly (i.e make /dev/*mem imutable, disalow
module loading, restrict io... (and I admit it is quite complicated to find
all holes and secure it correctly without additional ptches like SELinux))
then even root cant gt arround immutable or append only (without rebooting).

Greetings
Bernd
