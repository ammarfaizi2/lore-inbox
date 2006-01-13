Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423083AbWAMWta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423083AbWAMWta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423081AbWAMWta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:49:30 -0500
Received: from quechua.inka.de ([193.197.184.2]:22212 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1423083AbWAMWt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:49:29 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: Quota on xfs vfsroot
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <Pine.LNX.4.61.0601132126110.25429@yvahk01.tjqt.qr>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1ExXjb-00022r-00@calista.inka.de>
Date: Fri, 13 Jan 2006 23:49:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> the xfs_quota manpage says that one needs to use the "root-flags=" boot 
> parameter to enable quota for the root filesystem, but I do not see a 
> matching __setup() definition anywhere in the fs/xfs/ folder. So, how do I 
> have quota activated then?

init/do_mounts.c:__setup("rootflags=", root_data_setup);

It is a general boot line flag, not xfs specific.

Gruss
Bernd
y
