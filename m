Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTD2L0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 07:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTD2L0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 07:26:43 -0400
Received: from mail.gmx.net ([213.165.65.60]:54507 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261595AbTD2L0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 07:26:42 -0400
Message-ID: <3EAE644A.2000101@gmx.net>
Date: Tue, 29 Apr 2003 13:38:50 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Martin List-Petersen <martin@list-petersen.dk>, bas.mevissen@hetnet.nl,
       linux-kernel@vger.kernel.org
Subject: Re: Broadcom BCM4306/BCM2050  support
References: <1051596982.3eae18b640303@roadrunner.hulpsystems.net> <1051614381.21135.5.camel@rth.ninka.net>
In-Reply-To: <1051614381.21135.5.camel@rth.ninka.net>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Mon, 2003-04-28 at 23:16, Martin List-Petersen wrote:
> 
>>>I couldn't find any Linux support for these WLAN chips with 
>>>google or on this lists archives. So I would like to ask it here:
>>
>>It seems, that the specs haven't been released yet. There are quite a few Wlan
>>cards out there based on the Broadcom chips (nearly all cards, that support
>>802.11g), so it's quite a shame. (Actually this fits the the TrueMobile 1180,
>>1300 and 1400, speaking of Dell wireless lan cards).
> 
> ...
> 
>>The same problem is with the Intel Prowireless 2100 (Centrino) WLan card. No
>>Linux support available yet, which is another choice for the Dell notebooks at
>>the moment.
> 
> 
> Don't expect specs or opensource drivers for any of these pieces
> of hardware until these vendors figure out a way to hide the frequency
> programming interface.
> 
> Ie. these cards can be programmed to transmit at any frequency,
> and various government agencies don't like it when f.e. users can
> transmit on military frequencies and stuff like that.

Cool.

> The only halfway plausible idea I've seen is to not document the
> frequency programming registers, and users get a "region" key file that
> has opaque register values to program into the appropriate registers.
> The file is per-region (one for US, Germany, etc.)and the wireless
> kernel driver reads in this file to do the frequency programming.
> 
> So don't blame the vendors on this one, several of them would love
> to publish drivers public for their cards, but simply cannot with
> upsetting federal regulators.

/me wants binary only driver for these cards to build opensource driver
with ability to set "interesting" frequency range.


Carl-Daniel
-- 
http://www.hailfinger.org/

