Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbTI0QwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 12:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbTI0QwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 12:52:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62098 "EHLO
	VL-MO-MR005.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S262507AbTI0QwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 12:52:15 -0400
Date: Sat, 27 Sep 2003 12:48:32 -0400
From: Jean-Marc Spaggiari <Jean-Marc@Spaggiari.org>
Subject: Re: Kernel panic:Unable to mount root fs (2.6.0-test5)
In-reply-to: <20030927162443.68906.qmail@web40912.mail.yahoo.com>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3F75BF60.4000100@Spaggiari.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: fr-fr, fr-ca, fr-be, fr-lu, fr-mc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
References: <20030927162443.68906.qmail@web40912.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley Chapman wrote:

> 
> 
> Can you send more of the dmesg that comes from 2.6 when you try to boot it?
> (i.e. send more lines of it than the last few)
> 
> 

Please, can you explain me how can I do that ? BEcause when I'm starting 
with 2.6 kernel, it's hanging will starting, and when I'm starting with 
2.4.22 kernel, only informations about 2.4.22 is show by dmesg ...
(If the 2.6 can't mounty the /, maybe it's why it can't write 
information for dmesg on ?)

Here is what I can see on the screen :

floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
eth0: Realtek RTL8139 at 0xe3809f00, 00:08:0d:89:3c:38, IRQ 5
mice: PS/2 mouse device common for all mice
Synaptics Touchpad, model: 1
  Firware: 5.9
  Sensor: 15
  ne absolute packet format
  Touchpad has extended capability bits
  -> multifinger detection
  -> palm detection
input: Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60, 0x64 irq 1
NET: Registred protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registerd protocol family 1
VFS: Cannont open root device "302" or unknown-block(3,2)
Please append a correct "root=" boot option
Kernel panics: VFS: Unable to mount root fr onunknown-block(3,2)

That's all. I will try to modify the number of line of the screen in the 
bis for seeing more information, but I can't promise anythinks ...

JMS.

