Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268490AbTCCQ3F>; Mon, 3 Mar 2003 11:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268557AbTCCQ3E>; Mon, 3 Mar 2003 11:29:04 -0500
Received: from 195-219-31-160.sp-static.linix.net ([195.219.31.160]:51329 "EHLO
	r2d2.office") by vger.kernel.org with ESMTP id <S268490AbTCCQ3D>;
	Mon, 3 Mar 2003 11:29:03 -0500
Message-ID: <3E638522.3080008@walrond.org>
Date: Mon, 03 Mar 2003 16:38:58 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Dmesg: Use a PAE enabled kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The dump looks like this:

BIOS-provided physical RAM map:
   BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
   BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
   BIOS-e820: 0000000000100000 - 00000000bfffa000 (usable)
   BIOS-e820: 00000000bfffa000 - 00000000bffff000 (ACPI data)
   BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
   BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
   BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
   BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
   BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
Warning only 4GB will be used.
Use a PAE enabled kernel.
3200MB HIGHMEM available.
896MB LOWMEM available.

So you are saying that not all the 4Gb of ram will get mapped/used
(specifically, everything not marked 'usable') ?

Can you quantify the performance degredation of a PAE enabled kernel?

Andrew Walrond



