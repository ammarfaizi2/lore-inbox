Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbTAJVPp>; Fri, 10 Jan 2003 16:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbTAJVPp>; Fri, 10 Jan 2003 16:15:45 -0500
Received: from air-2.osdl.org ([65.172.181.6]:1515 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266100AbTAJVPo>;
	Fri, 10 Jan 2003 16:15:44 -0500
Date: Fri, 10 Jan 2003 13:20:46 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Manish Lachwani <m_lachwani@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Using lilo to boot off any drive ...
In-Reply-To: <20030110210035.76482.qmail@web20502.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33L2.0301101318220.19536-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Manish Lachwani wrote:

| In my current setup, I am having 12 ide drives
| connected to a 3ware controller labelled sda to sdl.
| Suppose sde is the drive we want the system to boot
| off. What I do is modify the lilo.conf on sda, sdb,
| sdc etc. to have the "boot" entry point to /dev/sde.
|
| This way when the controller is transferred to lilo on
| sda, it will load the kernel from sde.
|
| consider this. If sda is bad and is not exported to
| the OS or is not detected in the BIOS due to a bad
| cable etc. In this scenario, the OS mappings would
| change. Now, sdb will become sda. The lilo.conf on sdb
| (now sda) would have "boot" parameter still point to
| sde, which is now sdd.
|
| When the control is transferred to lilo on sda (sdb
| actually), is there a way for me to boot off sdd now
| (which was previously sde)? I mean, is there any way
| that lilo can load the appropriate kernel image?
|
| One of the ways I was thinking of was to modify the
| lilo sources to scan for drive serial# and we boot off
| that drive for which the serial# matches. But, does
| anyone have a better alternative?

I'm missing some info about how a BIOS addresses a large
number of IDE drives.  I know about the basic 0x80 = hda
(or C:) and 0x81 = hdb.  Is this still used?
Is it extended for even many more drives?

-- 
~Randy

