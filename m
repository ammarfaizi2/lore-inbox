Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbSL0M4r>; Fri, 27 Dec 2002 07:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbSL0M4r>; Fri, 27 Dec 2002 07:56:47 -0500
Received: from extern.genomatix.de ([213.221.100.139]:18641 "EHLO
	mail.genomatix.de") by vger.kernel.org with ESMTP
	id <S264915AbSL0M4q>; Fri, 27 Dec 2002 07:56:46 -0500
Message-ID: <3E0C4FF9.1010100@mailsammler.de>
Date: Fri, 27 Dec 2002 14:04:57 +0100
From: Torben Frey <kernel@mailsammler.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: de-de, de, en, en-us
MIME-Version: 1.0
To: Nuno Silva <nuno.silva@vgertech.com>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <3E01D7D7.2070201@mailsammler.de> <3E0276B9.40001@vgertech.com>
In-Reply-To: <3E0276B9.40001@vgertech.com>
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh problem?)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nuno,

> AFAIK, this is because you have some GB of memory (RAM) that are beeing 
> used as disk-cache. It took 22 seconds for the cached writes-to-disk 
> being flushed to the device.

Yes, I guess you are right...must be the flushing of my buffers, altogether it writes out 
exactly the amount of data I would expect (the "22seconds block" included).

Regards,
Torben

PS: Sorry for my long delay, but I was at home over Xmas and could not reply earlier.

