Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWJHBW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWJHBW2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 21:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWJHBW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 21:22:28 -0400
Received: from uni20mr.unity.ncsu.edu ([152.1.2.39]:9951 "EHLO
	uni20mr.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S1750712AbWJHBW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 21:22:27 -0400
Subject: Re: Unable to find root fs with libata only 2.6.18-mm3
From: Casey Dahlin <cjdahlin@ncsu.edu>
To: Ed Sweetman <safemode2@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45284BE0.7030600@comcast.net>
References: <45284BE0.7030600@comcast.net>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 21:22:23 -0400
Message-Id: <1160270544.10398.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.2.0.264296, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2006.10.7.174443
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My question is, do I still need to compile in scsi disk/cdrom/generic 
> support into my kernel to get libata devices to work or is there some 
> other syntax i'm missing?

The initrd image provides the ramdisk image which contains modules not
compiled into the kernel which are necessary to access the root
filesystem. Man mkinitrd should explain how to set it up.

Casey Dahlin


