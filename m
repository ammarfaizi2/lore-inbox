Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWCTT7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWCTT7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWCTT7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:59:08 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:12216 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030186AbWCTT7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:59:06 -0500
Date: Mon, 20 Mar 2006 20:58:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Dike <jdike@addtoit.com>
cc: Matheus Izvekov <mizvekov@gmail.com>, Neil Brown <neilb@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Who uses the 'nodev' flag in /proc/filesystems ???
In-Reply-To: <20060320194815.GA6376@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.61.0603202057420.14231@yvahk01.tjqt.qr>
References: <17436.60328.242450.249552@cse.unsw.edu.au>
 <Pine.LNX.4.61.0603191024420.1409@yvahk01.tjqt.qr> <17438.13214.307942.212773@cse.unsw.edu.au>
 <Pine.LNX.4.61.0603201659250.22395@yvahk01.tjqt.qr>
 <305c16960603200817u3c8e4023nf2621245fdb0ed65@mail.gmail.com>
 <20060320175633.GA5797@ccure.user-mode-linux.org>
 <305c16960603201122t79dd93c1t484c83acf4ed191b@mail.gmail.com>
 <20060320194815.GA6376@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I see, i didnt know about this. But then pam_mount would need to do
>> special treatment for this. I imagine it has been only coded to work
>> in the case where there is a device to pass to fsck as a parameter.
>
>Yeah, I don't doubt it.  I was just commenting on the nodev aspect of this.
>

But hey, when hostfs is nodev-but-fsckable, then looking for /sbin/fsck.XYZ 
is even better than reading /proc/filesystems...


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
