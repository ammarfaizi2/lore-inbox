Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbUJaLlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbUJaLlK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 06:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbUJaLlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 06:41:02 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:41155 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261539AbUJaK5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:57:41 -0500
Subject: Re: 2.6.10-rc1 crashes on recursive directory walk [2.6.9 was OK]
From: Alexander Nyberg <alexn@dsv.su.se>
To: dap <dap@kenyer.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1099156115.14842.322.camel@localhost>
References: <1099156115.14842.322.camel@localhost>
Content-Type: text/plain
Message-Id: <1099220254.677.6.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 31 Oct 2004 11:57:34 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I've used xfs and ext3 on a large ftp server with lots of files, and
> when I do a 'find / -ls' with the kernel 2.6.10-rc1, the server crashes
> with no Oops or other message. only the reset button give a response.. I
> can reproduce it any time with find, but the point of crash is random,
> it can crash on xfs and ext3 partitions too..  2.6.9 works fine in this
> environment..
> 
> 
> vm settings:
> 
> echo 16384 > /proc/sys/vm/min_free_kbytes
> echo 28 > /proc/sys/vm/vfs_cache_pressure
> echo 100 > /proc/sys/vm/swappiness
> 
> I've tried to double min_free_kbytes but didn't help
> 

Hi,

.config & dmesg please, I can't seem to be able to reproduce this under
me own environment. Also a little more description of how the setup
looks like would be nice, I've only gathered one or more raid5 arrays
with xfs and ext3 involved.

