Return-Path: <linux-kernel-owner+w=401wt.eu-S932789AbWLaFOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbWLaFOo (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 00:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbWLaFOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 00:14:44 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:44334 "EHLO
	mtiwmhc12.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932746AbWLaFOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 00:14:43 -0500
Message-ID: <45974752.90601@lwfinger.net>
Date: Sat, 30 Dec 2006 23:14:58 -0600
From: Larry Finger <larry.finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: Aaron Sethman <androsyn@ratbox.org>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, st3@riseup.net,
       linville@tuxdriver.com, netdev@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [OOPS] bcm43xx oops on 2.6.20-rc1 on x86_64
References: <Pine.LNX.4.64.0612171510030.17532@squeaker.ratbox.org> <20061230192104.GB20714@stusta.de> <Pine.LNX.4.64.0612302312520.27190@squeaker.ratbox.org>
In-Reply-To: <Pine.LNX.4.64.0612302312520.27190@squeaker.ratbox.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Sethman wrote:
> 
> On Sat, 30 Dec 2006, Adrian Bunk wrote:
> 
>> On Sun, Dec 17, 2006 at 03:15:28PM -0500, Aaron Sethman wrote:
>>>
>>> Just was loading the bcm43xx module and got the following oops. Note
>>> that
>>> this card is one of the newer PCI-E cards.  If any other info is needed
>>> let me know.
>>
>> Is this issue still present in 2.6.10-rc2-git1?
>>
>> If yes, was 2.6.19 working fine?
>>
> 
> This seems to be fixed in 2.6.20-rc2-git1.  Still having other issues
> with the driver, but the oops in the SoftMAC code is resolved now at least.

I have just started working with the PCI-E BCM4311 that is in my new computer. It receives data OK,
but there is something wrong with the DMA out stuff in bcm43xx-softmac - at least for x86_64. All
the slots get full but nothing is ever transmitted. FWIW, the wireless-dev git tree works. I'm using
it for communications now. I'm using openSUSE 10.2 which uses NetworkManager to configure my WPA-PSK
TKIP encrypted network. The signal strengths are roughly the same as I got for my old BCM4306 card.

I will post any fixes for the DMA problem as soon as they are available, but it may be a while. I
will be off-line until Thursday while I attend a funeral.

Larry

