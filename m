Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbSLFSEh>; Fri, 6 Dec 2002 13:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSLFSEh>; Fri, 6 Dec 2002 13:04:37 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:29901 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265570AbSLFSEg>;
	Fri, 6 Dec 2002 13:04:36 -0500
Message-ID: <3DF0E878.5020005@colorfullife.com>
Date: Fri, 06 Dec 2002 19:12:08 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.20] Problems with yenta PCMCIA socket (worked with 2.4.19)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With 2.4.20 it gives
> my "Resource unavailable" messages when a plug in my hermes/orinoco
> based wireless lan card. There hasn't been any changes in the PCMCIA
> code between 2.4.19 and 2.4.20. What can be the problem? ACPI related?
> 
Which chipset?

Could you post the dmesg log, /proc/ioports, /proc/iomem and lspci -v?

Perhaps it's a problem with the transparent bridge detection.

--
	Manfred

