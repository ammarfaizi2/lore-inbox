Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbUCKWkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUCKWkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:40:41 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:37772 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261802AbUCKWkf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:40:35 -0500
Message-ID: <4050EC1F.2060005@tmr.com>
Date: Thu, 11 Mar 2004 17:45:51 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Dax Kelson <dax@gurulabs.com>,
       James Ketrenos <jketreno@linux.co.intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Announce] Intel PRO/Wireless 2100 802.11b driver
References: <404E27E6.40200@linux.co.intel.com> <1078866774.2925.15.camel@mentor.gurulabs.com> <200403101015.19506.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200403101015.19506.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda wrote:

> *FLAME ALERT*
> /me is slowly getting mad about his prism54 11g hardware
> and its firmware, with neither firmware authors nor documentation
> for this pile of silicon crap nowhere in sight
> 
> What's so cool about having binary firmware? Bugs are bugs,
> and you won't be able to even see bugs, less fix, in it.
> I don't like being at the mercy of firmware authors.

There are two common reasons for binary firmware:
1 - it runs on some sort of a state machine implemented in an ASIC or 
other device for which you have no manuals or assembler.
2 - since these devices are regulated all to hell by the FCC and other 
non-technical groups balancing technical advice with political pressure, 
a user might code the device out of spec, causing some manner of legal 
hassle.

I don't know if (1) applies here, but I'd bet (2) is applicable.

Let's be happy that we have a driver and treat the device as a black 
box. There are people paid to know enought details to write firmware, 
I'm happy to treat NICs and CD/DVD burners with the "buy good and update 
firmware at the first problem." Keeping the old firmaware of course.

		-bill
