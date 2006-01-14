Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751680AbWANJfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbWANJfi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 04:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWANJfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 04:35:38 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:7126 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751677AbWANJfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 04:35:37 -0500
Date: Sat, 14 Jan 2006 10:35:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bernd Eckenfels <be-news06@lina.inka.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Quota on xfs vfsroot
In-Reply-To: <E1ExXjb-00022r-00@calista.inka.de>
Message-ID: <Pine.LNX.4.61.0601141033190.25932@yvahk01.tjqt.qr>
References: <E1ExXjb-00022r-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> the xfs_quota manpage says that one needs to use the "root-flags=" boot 
>> parameter to enable quota for the root filesystem, but I do not see a 
>> matching __setup() definition anywhere in the fs/xfs/ folder. So, how do I 
>> have quota activated then?
>
>init/do_mounts.c:__setup("rootflags=", root_data_setup);
>It is a general boot line flag, not xfs specific.

Ah, thank you.
Weird manpage program wrapped rootflags into "root-\nflags" at EOL, sigh.



Jan Engelhardt
-- 
