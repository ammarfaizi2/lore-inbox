Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUBJSrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266285AbUBJSps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:45:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53471 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266274AbUBJSo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:44:59 -0500
Message-ID: <40292699.7070200@pobox.com>
Date: Tue, 10 Feb 2004 13:44:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Horsten <thomas@horsten.com>
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: ATARAID userspace configuration tool
References: <Pine.LNX.4.40.0402101743020.28534-100000@jehova.dsm.dk>
In-Reply-To: <Pine.LNX.4.40.0402101743020.28534-100000@jehova.dsm.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Horsten wrote:
> That's true of course, one example would be to remove the RAID superblock
> with dd. The problem is if this is done by mistake, it could be
> catastrophic. It might be enough to remove the wrong partitions (with
> BLKPG_DEL_PARTITION, thanks to Matt Domsch for pointing me in the right
> direction), it will at least prevent mkfs /dev/hda1 etc, which would have
> unforeseeable consequences.


There are 1001 things that could have unforseen consequences, when root 
is doing something ;-)

This is getting into the area of standard Linux kernel policy (or lack 
thereof):  let root shoot himself in the foot, if he wishes.

I would certainly -want- to be able to dd -from- my underlying disks, 
even if an ataraid or md device is sitting on top, for example.

	Jeff



