Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbTBCVJm>; Mon, 3 Feb 2003 16:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbTBCVJm>; Mon, 3 Feb 2003 16:09:42 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:55224 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S262449AbTBCVJk>; Mon, 3 Feb 2003 16:09:40 -0500
Message-ID: <3E3EDC9A.9060102@bogonomicon.net>
Date: Mon, 03 Feb 2003 15:18:18 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Compactflash cards dying?
References: <200302031425.h13EP0RX015976@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take a look at all the embedded Linux distributions.  There are 
solutions for this out there.  I haven't looked into them as I just 
stuck a hole PC into my robot.

The issue with ROM style data storage is once written, any changes 
require replacement of the devices.  That adds up after a few revisions. 
  All motherboards once had PROMS (usually windowless EPROMS) for 
storing the BIOS.  It is just the cost of FLASH type devices has come 
down to the point where they are cheep when you look at the costs of 
going about it some other way.

- Bryan

> On a somewhat-related subject, is there currently an easy way to use a
> PROM as a read-only filesystem?
> 
> I.E. I'd like to write a raw filesystem image to an PROM using a PROM
> burner then connect that, probably to the parallel port, and use it as
> a block device.
> 
> It should be fairly simple to build the parallel port -> PROM adaptor,
> as it would essentially just be a ZIF socket, and a whole load of
> latches to multiplex the limited number of I/O lines to the 32 or so
> needed for address and data, and the driver should be straightforward
> to write as well.
> 
> Or is there a reason why this hasn't been done?  PROMs are much
> cheaper than Compact Flash...



