Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273049AbTHFA4C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273060AbTHFA4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:56:02 -0400
Received: from dyn-ctb-210-9-244-102.webone.com.au ([210.9.244.102]:24326 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S273049AbTHFAz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:55:56 -0400
Message-ID: <3F305205.2010705@cyberone.com.au>
Date: Wed, 06 Aug 2003 10:55:33 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Chubb <peter@chubb.wattle.id.au>
CC: Andrew Morton <akpm@osdl.org>, Martin Konold <martin.konold@erfrakon.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Interactive Usage of 2.6.0.test1 worse than 2.4.21
References: <200308050704.22684.martin.konold@erfrakon.de>	<20030804232654.295c9255.akpm@osdl.org> <16176.13066.601441.179810@wombat.chubb.wattle.id.au>
In-Reply-To: <16176.13066.601441.179810@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Chubb wrote:

>>>>>>"Andrew" == Andrew Morton <akpm@osdl.org> writes:
>>>>>>
>
>Andrew> Martin Konold <martin.konold@erfrakon.de> wrote:
>
>>>Hi,
>>>
>>>when using 2.6.0.test1 on a high end laptop (P-IV 2.2 GHz, 1GB RAM)
>>>I notice very significant slowdown in interactive usage compared to
>>>2.4.21.
>>>
>>>The difference is most easily seen when switching folders in
>>>kmail. While 2.4.21 is instantaneous 2.6.0.test1 shows the clock
>>>for about 2-3 seconds.
>>>
>>>
>
>I see the same problem, and I'm using XFS.  Booting with
>elevator=deadline fixed it for me.  The anticipatory scheduler hurts
>if you have a disc optimised for low power consumption, not speed.
>
>

I don't think this generalisation is really fair. All hard disks
have the same basic properties which AS exploits. There seems to
be something going wrong though.


