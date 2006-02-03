Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWBCOIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWBCOIY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 09:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWBCOIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 09:08:24 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:13585 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750829AbWBCOIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 09:08:23 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Re: WLAN drivers
Date: Fri, 3 Feb 2006 12:35:30 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
References: <1138969138.8434.26.camel@localhost.localdomain>
In-Reply-To: <1138969138.8434.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602031235.31098.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 February 2006 12:18, Panagiotis Issaris wrote:
[snip]
> And, finally, it seems a lot of cards that get recommendations, are
> based on rather old chipsets, which are unlikely to be still sold today.

This is especially true of the once ubiquitous prism chipsets.

> And now the reason I'm sending this to this mailing list: Which wireless
> network cards are you all using and which ones would you recommend? Is
> anyone using USB wireless network cards (without using ndiswrapper)?

In my experience, you're simply best going to either http://prism54.org/ (if 
you can find one still) or http://madwifi.org/ (modern cards, likely to be 
purchasable), and then buying one of the cards on the "known to work" lists. 
If you buy the wrong revision, return it.

There's really nothing Linux can do about vendors who annoyingly change their 
entire product description (and chipset) between revisions.

Personally I've successfully used a 3Com OfficeConnect 11g 1.0 (probably 
discontinued) which uses the prism54 driver, Intel's Centrino IPW2200BG and 
Proxim's new Orinoco Gold cardbus card (with the madwifi.org drivers).

Keywords for _modern_ Linux supported wireless chipsets are still (to my 
knowledge) atheros, atmel, prism54, and most recently broadcom, though that 
support is currently immature.

Also possibly the Ralink chipsets are worth considering, they seem to have 
been pretty open with respect to drivers, and the cards are dirt cheap.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
