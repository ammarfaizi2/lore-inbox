Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbUJZJLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUJZJLn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 05:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbUJZJLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 05:11:43 -0400
Received: from outmx015.isp.belgacom.be ([195.238.2.87]:14237 "EHLO
	outmx015.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261884AbUJZJLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 05:11:33 -0400
Date: Tue, 26 Oct 2004 11:11:20 +0200 (CEST)
From: hans lambrechts <hans.lambrechts@skynet.be>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.10-rc1 doesn't boot
In-Reply-To: <20041025160924.0adb3d32.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0410261102310.7477@pc.home.lan>
References: <Pine.LNX.4.58.0410231616120.6852@pc.home.lan>
 <20041025160924.0adb3d32.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,
everthing is OK now.
I managed to empty my 'usr/initramfs_list'. (I've put the wrong directory 
into the config option)
I've noticed this when 'patch - R' was complaining when I removed the 
2.6.10-rc1 patch. I've tried 2.6.9-mm1 and this also works fine.

My box is running 2.6.10-rc1-bk3 atm and is working as expected.

Greetings,
Hans

On Mon, 25 Oct 2004, Andrew Morton wrote:

> hans lambrechts <hans.lambrechts@skynet.be> wrote:
> >
> > when i'm booting my box with kernel 2.6.10-rc1 i get this message:
> > 
> > 	VFS: cannot open root device "sdb7" or unknown-block (8,32)
> > 
> > i've tried "root=8:32" w/o any improvement
> > kernel 2.6.9 is booting w/o complaining with "root=/dev/sdb7"
> 
> Probably something has gone wrong with the device known as sdb.  Or its
> driver.  We'd need to see more of the boot messages to tell.  Did the scsi
> layer say anything nasty when it was probing devices?
> 
> 
