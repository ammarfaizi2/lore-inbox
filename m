Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbUKAIs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUKAIs0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 03:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbUKAIs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 03:48:26 -0500
Received: from main.gmane.org ([80.91.229.2]:42989 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261597AbUKAIsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 03:48:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Amit Shah <shahamit@gmail.com>
Subject: Re: No PS2 with ACPI [was Re: 2.6.10-rc1-mm2]
Date: Mon, 01 Nov 2004 14:16:13 +0530
Message-ID: <cm4t8f$pd7$1@sea.gmane.org>
References: <20041029014930.21ed5b9a.akpm@osdl.org> <1099149503l.23066l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: calvin.codito.com
User-Agent: KNode/0.8.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

> On 2004.10.29, Andrew Morton wrote:
>> 
>>
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/
>> 
>> 
> 
> Here we go again...
> 
> With normal boot, I have no kbd nor mouse (both PS2).
> 2.6.9-mm1 detects them correctly:
> 
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: PS2++ Logitech <NULL> on isa0060/serio1
> 
> 2.6.10-rc1-mm2 misses the two 'input' lines, I just get the 'mice:' one.

I too get the same error. I have a Pentium 4, not an AMD64.

> Booting with i8042.noacpi makes them work again.

Checking...

-- 
Amit Shah
http://amitshah.nav.to/

