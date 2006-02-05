Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWBEUN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWBEUN7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 15:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWBEUN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 15:13:59 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:43428 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750713AbWBEUN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 15:13:58 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43E65B6A.4090301@s5r6.in-berlin.de>
Date: Sun, 05 Feb 2006 21:09:14 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: Kyle Moffett <mrmacman_g4@mac.com>, Andrew Morton <akpm@osdl.org>,
       Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 4/4] firewire: add mem1394
References: <1138919238.3621.12.camel@localhost> <1138920185.3621.24.camel@localhost> <20060205004327.78926498.akpm@osdl.org> <C815B7F7-75F9-404A-9358-FD6E3E08699A@mac.com> <43E5D599.5040503@s5r6.in-berlin.de>
In-Reply-To: <43E5D599.5040503@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.655) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
(ohci1394's programming of physical DMA filters)
> The else clause is BTW bogus [...], but this is only 
> important if an IEEE 1394.1 bus bridge was present.

I had a closer look. Physical DMA _is_ reliably disabled for all nodes 
(including nodes on bridged buses) if ohci1394 was loaded with phys_dma=0.
-- 
Stefan Richter
-=====-=-==- --=- --=-=
http://arcgraph.de/sr/
