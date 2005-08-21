Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVHUGnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVHUGnE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 02:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVHUGnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 02:43:01 -0400
Received: from [209.18.121.242] ([209.18.121.242]:32016 "EHLO
	mailrelay.wirelesslogixgroup.com") by vger.kernel.org with ESMTP
	id S1750775AbVHUGnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 02:43:01 -0400
Message-ID: <43082267.2030009@jtholmes.com>
Date: Sun, 21 Aug 2005 02:42:47 -0400
From: "j.t. holmes" <linux@jtholmes.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12.5 stalls on boot
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.12.5 and others below that to 2.6.10  stall on boot. The problem is 
udev.

It stalls between 1 to 3 minutes.

I have the latest 

udev
hotplug
klibc

u name it

Something happened about 2.6.11.X and I see others writing about
similar items

The base system is Suse 9.2  and I am beginning to wonder if
there is something that Suse wrote that is interferring w/the boot.
Since they shipped 9.2 with a 2.6.8-24 and there have been a lot
of changes up to 2.6.12.5

In any case the  boot  stalls  just after it prints these two lines

input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio4

and about 2 mins + -  later it prints this

EXT2-fs warning (device hda6): ext2_fill_super: mounting ext3 filesystem 
as ext2
and then continue normal boot

I sent in  an  ALT SYSREQ  P  and T  trace a few weeks ago
but didnt get an answer.

Am I incorrect in assuming that everything up until the root disk is mounted
is primarily kernel activity? If not then where else can I look.

I can provide any info desired.

Just in case this is Suse related I am going to load  9.3  early next week
and compile  2.6.12.5 on it and see it I encounter the stall problem. I will
post the results from the activity.






