Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270666AbTG0EZD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 00:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270664AbTG0EZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 00:25:03 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:3535 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S270666AbTG0EZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 00:25:00 -0400
Message-ID: <3F235B73.70701@genebrew.com>
Date: Sun, 27 Jul 2003 00:56:19 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew de Quincey <adq_dvb@lidskialf.net>
CC: lkml <linux-kernel@vger.kernel.org>, Laurens <masterpe@xs4all.nl>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
References: <200307262309.20074.adq_dvb@lidskialf.net>
In-Reply-To: <200307262309.20074.adq_dvb@lidskialf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew de Quincey wrote:
> Small patch for the latest nvidia nforce 1.0-261 nvnet drivers with kernel 2.5.

Further nvnet musings (cc:ing Jeff as net driver maintainer and 
knowledgeable person).

As I reported here a few days earlier, I tried using the AMD8111 driver 
with my NForce2 ethernet a few days ago, with the result that no MAC 
address was being assigned to the card. I suspect that the MAC address 
is being assigned by the Nvidia driver. Does that make sense?

If so, then using the option in the BIOS to manually set the MAC address 
might make the AMD driver work. Unfortunately, I have no idea what I 
should set it to without stomping on the MAC address for other devices.

Any ideas? I hate to rely on a binary only module for something as 
"simple" as a 10/100 ethernet card.

Thanks,
Rahul

