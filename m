Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbTEETon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTEETon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:44:43 -0400
Received: from mail.gmx.de ([213.165.65.60]:2804 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261261AbTEETom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:44:42 -0400
Message-ID: <3EB6C20E.6040700@gmx.net>
Date: Mon, 05 May 2003 21:57:02 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Ezra Nugroho <ezran@goshen.edu>, linux-kernel@vger.kernel.org
Subject: Re: partitions in meta devices
References: <1052153060.29588.196.camel@ezran.goshen.edu> <3EB693B1.9020505@gmx.net> <1052153834.29676.219.camel@ezran.goshen.edu> <3EB69883.8090609@gmx.net> <20030505191604.GC10374@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030505191604.GC10374@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, May 05, 2003 at 06:59:47PM +0200, Carl-Daniel Hailfinger wrote:
>  
>>Could you please tell us which kernel version you're using?
> 
> 	What would be much more interesting, which kernel are _you_ using
> and what device numbers, in your experience, do these partitions get?

2.4.21-rc1 and no, I don't use RAID devices. Just plain old partitions
on /dev/hda, CONFIG_MSDOS_PARTITION=y

Ezra Nugroho wrote:

>>>     Device Boot    Start       End    Blocks   Id  System
>>> /dev/md0p1             1  24414064  97656254   83  Linux
>>> /dev/md0p2      24414065  60313632 143598272   83  Linux

That confused me. Assuming these entries were correct, I tried the
standard "kernel sees new partitions only after reboot" procedure.
GIGO.

