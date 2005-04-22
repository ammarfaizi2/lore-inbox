Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVDYQu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVDYQu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVDYQr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 12:47:28 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:26761 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262684AbVDYQrF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:47:05 -0400
Message-ID: <426942CC.2010702@tmr.com>
Date: Fri, 22 Apr 2005 14:30:36 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shaun Jackman <sjackman@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: netdev watchdog
References: <7f45d939050421152171400450@mail.gmail.com>
In-Reply-To: <7f45d939050421152171400450@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaun Jackman wrote:
> Upon booting my system, the boot fails and the following message is
> displayed repeatedly:
> 
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out, tx_status 00 status eb01.
> diagnostics: net 0cfa media 88c0 dma 0000003a fifo 0000
> eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
> Flags; bus-master 1, dirty 65(1) current 65(1)
> Transmit list 00000000 vs d0c782a0
> 0: @d0c78200 length 8000002e status 8001002e
> ...
> 
> I also see the same message for eth2. I'd been happily booting this
> 2.6.8.1 kernel for months without trouble. I don't know where this is
> coming from. The drivers for my three NICs are forcedeth, 3c59x, and
> 8139too. I'd be happy to give more information to help.

If you're looking for general causes did you plug in any other devices, 
on PCI or on USB/firewire? Add a disk, anything like that.

If you want real help you need to provide the usual information, see the 
BUG REPORTS doc in the source in the Documentation directory as I recall.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

