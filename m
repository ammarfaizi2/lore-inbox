Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262485AbTCRSEc>; Tue, 18 Mar 2003 13:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262494AbTCRSEc>; Tue, 18 Mar 2003 13:04:32 -0500
Received: from bestroot.de ([217.160.170.131]:37855 "EHLO
	p15112267.pureserver.de") by vger.kernel.org with ESMTP
	id <S262485AbTCRSEb>; Tue, 18 Mar 2003 13:04:31 -0500
Message-ID: <3E77635D.5080306@elitedvb.net>
Date: Tue, 18 Mar 2003 19:20:13 +0100
From: Felix Domke <tmbinc@elitedvb.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE 48 bit addressing causes data corruption
References: <3E772DA1.5080504@elitedvb.net> <1048004672.27223.65.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> LBA48 support and UDMA100/133 support are unrelated to one another.
> There are controllers with one or the other, eg the older ALi can do
> UDMA133 but not LBA48

OK, looks bad for me.

Just for my interest:

Why does a certain IDE controller not support LBA48?

I always thought an IDE controller isn't more than some ISA-styled bus 
with 3 address lines, 2 chip  selects and special stuff for 
DMA-transfers, together with very special timing generators for PIO-modes.

Whats the problem with these controllers? LBA48, i thought, isn't more 
than writing the LBA-registers twice (because of the FIFO), and using 
different commands for reading/writing (the _EXT functions).

felix

