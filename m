Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319110AbSHTAA0>; Mon, 19 Aug 2002 20:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319113AbSHTAA0>; Mon, 19 Aug 2002 20:00:26 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:489 "EHLO fed1mtao01.cox.net")
	by vger.kernel.org with ESMTP id <S319110AbSHTAA0>;
	Mon, 19 Aug 2002 20:00:26 -0400
Message-ID: <3D618789.7040408@cox.net>
Date: Mon, 19 Aug 2002 17:04:25 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1b) Gecko/20020721
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stanislav Brabec <utx@penguin.cz>
CC: Paul Bristow <paul@paulbristow.net>, linux-kernel@vger.kernel.org
Subject: Re: ide-floppy & devfs - /dev entry not created if drive is empty
References: <20020818185620.GA6013@utx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are patches at http://members.cox.net/kpfleming/ide-floppy to 
resolve this.

Stanislav Brabec wrote:
> Hallo Paul Bristow,
> 
> I have tested ide-floppy on my Linux 2.4.19 with ATAPI ZIP 100. I am
> using devfs.
> 
> I found following problem:
> 
> If module ide-floppy is loaded and no disc is present in the drive,
> /dev/ide/host0/bus1/target1/lun0/disc entry is not created. Later
> inserted media cannot be checked in any way, because no /dev entry
> exists.
> 
> Older kernels have also this behavior.
> 
> Fix: Create .../disc entry in all cases, even if no disc is present.
> 

