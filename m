Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317370AbSFCLUT>; Mon, 3 Jun 2002 07:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317374AbSFCLUS>; Mon, 3 Jun 2002 07:20:18 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:31988 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S317370AbSFCLUR>; Mon, 3 Jun 2002 07:20:17 -0400
Date: Mon, 3 Jun 2002 03:20:17 -0400
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TRIVIAL: rwhron@earthlink.net: remove space in cache names
Message-ID: <20020603072017.GA726@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>   Changes "fasync cache" and "file lock cache" to have
>>>   the usual underscore.

>> If you are looking in this area already plese remove
>> the completely redundant and inconsistently used cache
>> suffix for some entry names too. 

> Well, that's a decent idea, sure. 

Somewhat tangential, but are the DMA entries in /proc/slabinfo
every incremented/used?  I've watched them on various x86 boxes
for a while and never noticed a non-zero num_active_objs,
total_objs, num_active_slabs, or total_slabs entry.

size-131072(DMA)       0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
..
size-128(DMA)          0      0    128    0    0    1
size-64(DMA)           0      0     64    0    0    1
size-32(DMA)           0      0     64    0    0    1

-- 
Randy Hron

