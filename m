Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbULHJzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbULHJzB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 04:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbULHJzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 04:55:01 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:56593 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261173AbULHJyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 04:54:54 -0500
Message-ID: <41B6D11D.9040107@hist.no>
Date: Wed, 08 Dec 2004 11:02:05 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
References: <87acsrqval.fsf@coraid.com> <20041206162153.GH16958@lug-owl.de> <20041207130015.GA983@openzaurus.ucw.cz>
In-Reply-To: <20041207130015.GA983@openzaurus.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>
>Well, at least it has a chance to correctly work in low-memory conditions,
>and it might be possible to swap over AoE.
>ARPs are real problem there.
>				Pavel
>  
>
Well, how about caching the hw address of the AoE device
somewhere in the data structure describing the block device?
Then you won't need to ARP for it, and I guess that address isn't
likely to change while the device is in use?

Helge Hafting
