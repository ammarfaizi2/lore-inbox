Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbUDLKtd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 06:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbUDLKtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 06:49:33 -0400
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:6784 "EHLO
	longlandclan.hopto.org") by vger.kernel.org with ESMTP
	id S262810AbUDLKta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 06:49:30 -0400
Message-ID: <407A7436.1040908@longlandclan.hopto.org>
Date: Mon, 12 Apr 2004 20:49:26 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Who maintains the atp870u driver? (ACARD PCI SCSI)
References: <40702B87.6080506@longlandclan.hopto.org> <20040407140254.GB10979@logos.cnet>
In-Reply-To: <20040407140254.GB10979@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> 
> No one really maintains it officially.
> 
> James Bottomley and Doug Ledford have done some fixes for it on v2.6, you might want 
> trying to ask them directly.
> 
> Sorry.

	Ahh okay.  I might try Linux 2.6 on this box, however after testing 
this card in an x86 machine I had, and watching it fail to complete 
POST, I'm guessing my problem is that the card is in fact, dead.

	I merely pulled it out of the Microserver, and plonked in my dedicated 
games server (P4 1.4GHz, 256MB RDRAM, MSI Motherboard -- Gentoo Linux 
1.4) and watched it boot.  I heard no beeps, saw nothing on screen, and 
the whole system just sat there.

	Near the sound card sockets, there's a set of 4 two-colour LEDs 
arranged vertically, which indicate system status -- I don't know what 
the meaning is.  (It'll probably be in the handbook I don't have -- the 
board is second hand off Ebay).  Normally these are all glowing green 
when the system is fully up.  Looking at it now, it halts with them 
(going towards board), green, red, red, red.  On removing the card, the 
machine comes up just fine.  I take it this means the card is dead.

	Out of interest, the card itself is an "ACARD AEC-6710S" with an 
ATP870IU-C chipset.

	Odd that the Microserver should work with it though -- even if it gets 
SCSI parity errors -- but I spose this explains the odd error messages. 
  Hrmm, looks like I'm back on the search for another SCSI card that 
fits... :-/ (Anyone managed to get a SCSI card working in a Cobalt Qube 
or Gateway Microserver?)

-- 
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Atomic Linux Project    <--->    http://atomicl.berlios.de/ |
+-------------------------------------------------------------+
