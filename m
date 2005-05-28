Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVE1IwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVE1IwV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 04:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVE1IwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 04:52:21 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:14267 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262505AbVE1IwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 04:52:18 -0400
In-Reply-To: <20050527112039.GA10084@linuxace.com>
References: <E1DbccR-00063Q-00@mta1.cl.cam.ac.uk> <20050527112039.GA10084@linuxace.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <875052371a3a7c5217e413d7250320f9@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: coreteam@netfilter.org, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, cedric@schieli.dyndns.org
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH] Avoid unncessary checksum validation in TCP/UDP netfilter
Date: Sat, 28 May 2005 09:48:50 +0100
To: Phil Oester <kernel@linuxace.com>
X-Mailer: Apple Mail (2.622)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27 May 2005, at 12:20, Phil Oester wrote:

> On Fri, May 27, 2005 at 12:03:08PM +0100, Keir Fraser wrote:
>> The TCP/UDP connection-tracking code in netfilter validates the
>> checksum of incoming packets, to prevent nastier errors further down
>> the road. This check is unnecessary if the skb is marked as
>> CHECKSUM_UNNECESSARY.
>
> It seems at least part of this has already been merged in 2.6.12-rc

It would be great if the UDP code also would observe 
CHECKSUM_UNNECESSARY. I'll wait for 2.6.12 to appear and then submit a 
new patch if UDP has been missed.

  Thanks,
  Keir

