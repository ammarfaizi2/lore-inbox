Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261457AbSJACkt>; Mon, 30 Sep 2002 22:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261458AbSJACkt>; Mon, 30 Sep 2002 22:40:49 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:1920 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261457AbSJACks>;
	Mon, 30 Sep 2002 22:40:48 -0400
Date: Mon, 30 Sep 2002 21:46:15 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Felipe Alfaro Solana <felipe_alfaro@msn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord, IDE-SCSI and 2.5.39
In-Reply-To: <F6wJqHcMtzvFPrcgYax00012f2a@hotmail.com>
Message-ID: <Pine.LNX.4.44.0209302141330.961-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2002, Felipe Alfaro Solana wrote:

> Can you try running "cat /dev/pg0"? Does it work for you?
> 
> I think "/dev/scd0" is used for normal CD-ROM access, i.e. mounting a CD, 
> etc. but I think "/dev/pg0" is the generic interface used for burning CDs, 
> erasing CD-RWs, etc.

[root@dad root]# cat /dev/pg0 > /dev/null
cat: /dev/pg0: No such device
[root@dad root]# cat /dev/pg1 > /dev/null
cat: /dev/pg1: No such device

It sees it as scd0 or scd1 (scsi cd?).  I can read and write to /dev/scd1 
(my burner) just fine; that is the device my system has seen for some time 
now.  

