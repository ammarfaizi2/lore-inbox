Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbSLHDIv>; Sat, 7 Dec 2002 22:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbSLHDIv>; Sat, 7 Dec 2002 22:08:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2826 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265126AbSLHDIu>;
	Sat, 7 Dec 2002 22:08:50 -0500
Message-ID: <3DF2B95E.5060706@pobox.com>
Date: Sat, 07 Dec 2002 22:15:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5][Trivial] VIA Rhine Kconfig entry
References: <20021208003456.GA12234@k3.hellgate.ch>
In-Reply-To: <20021208003456.GA12234@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:
> at it. Just barely resisted the temptation to make VIA Rhine conflict with
> IO-APIC -- that seems to emerge as a fatal combo.


Patch looks ok to me, I'll queue it.

I agree about IO-APIC -- though I also think the reports that replacing 
via-rhine with linuxfet, and changing nothing else, helps the situation.

It might be something cosmetic like silly dev->tx_timeout handling, or 
it might be something useful like a chip-specific patch [often happens 
with on-mobo chips] or even a north/south-bridge-specific fixup.

	Jeff



