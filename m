Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUAXWdy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 17:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUAXWdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 17:33:54 -0500
Received: from mail.gmx.de ([213.165.64.20]:5511 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262130AbUAXWdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 17:33:52 -0500
X-Authenticated: #21910825
Message-ID: <4012F2B7.3080800@gmx.net>
Date: Sat, 24 Jan 2004 23:33:27 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Jeff Garzik <jgarzik@pobox.com>, Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] [2.4] forcedeth network driver
References: <4012BF44.9@colorfullife.com> <4012D3C6.1050805@pobox.com> <20040124220545.GA3246@ucw.cz>
In-Reply-To: <20040124220545.GA3246@ucw.cz>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Sat, Jan 24, 2004 at 03:21:26PM -0500, Jeff Garzik wrote:
> 
>>>>>+static int alloc_rx(struct net_device *dev)
>>>>>+{
>>>
>>>[snip]
>>>
>>>>>+    return 0;
>>>>>+}
>>>>
>>>>skb_reserve() seems to be missing
>>>>
>>>
>>>Do you have specs that show that all nForce versions support unaligned 
>>>buffers? skb_reserve is a performance feature, I don't want to add it 
>>>yet. Testing that it works is on our TODO list.
>>
>>hmmmm, is nForce ever found on non-x86 boxes?  I would think that 
>>skb_reserve might be -required- for some platforms.
> 
> 
> AMD64 and PPC64 as far as I know. But you may consider the first one
> still a x86 box.

Hmmm. I thought only GeForce graphics were available on PPC64 and nForce
mainboard chipsets (including the onboard nic) were not.


Carl-Daniel
-- 
http://www.hailfinger.org/

