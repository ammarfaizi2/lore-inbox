Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUBWQdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUBWQdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:33:47 -0500
Received: from mail.tmr.com ([216.238.38.203]:23936 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261950AbUBWQdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:33:43 -0500
Message-ID: <403A2B69.2070508@tmr.com>
Date: Mon, 23 Feb 2004 11:33:45 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andreas.hartmann@fiducia.de
CC: linux-kernel@vger.kernel.org
Subject: Re: distinguish two identical network cards
References: <OF0D5B57F7.B29B3783-ONC1256E43.0035BF41@fiducia.de>
In-Reply-To: <OF0D5B57F7.B29B3783-ONC1256E43.0035BF41@fiducia.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andreas.hartmann@fiducia.de wrote:
> Hello!
> 
> Some clarification:
> It is important, that the cards can be distinguished without any user driven
> action - it must run automatically. The machines will be delivered to somebody
> who doesn't know anything about linux / unix. I must be able to do a
> configuration like that:
> 
> Physical upper card: eth0
> Physical lower card: eth1
> 
> The customer will be told, e.g.: plug in the network cable from switch a to the
> upper card, the cable to the switch b must be connected to the lower card.

Sorry, other than the already suggested use of nameif I don't see any 
other good way to do it. At some point the hardware should pass through 
the hands of someone who DOES know Linux enough to read the MAC address 
off the sticker usually found on the NIC, and set the config to match.

You better label the back of the NICs, if your customer can't identify 
the one with the blinking light (as previously suggested) they may have 
problems with UNIX terms like upper and lower ;-)

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
