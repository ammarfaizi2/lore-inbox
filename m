Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVESRbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVESRbY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 13:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVESRbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 13:31:24 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:51934 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261172AbVESRbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 13:31:19 -0400
Message-ID: <428CCD19.6030909@candelatech.com>
Date: Thu, 19 May 2005 10:30:01 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.7) Gecko/20050417 Fedora/1.7.7-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-os@analogic.com, Adrian Bunk <bunk@stusta.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, "Gilbert, John" <JGG@dolby.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>	 <20050518195337.GX5112@stusta.de>	 <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>	 <20050519112840.GE5112@stusta.de>	 <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com> <1116505655.6027.45.camel@laptopd505.fenrus.org>
In-Reply-To: <1116505655.6027.45.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> HZ may not exist. At all; people are trying to remove it. And userspace
> has no business knowing about it either.

It can be helpful to know what HZ you are running at, for instance if you care
very much about the (average) precision of a select/poll timeout.

You can hack work-arounds to poor precision here using the /dev/rtc, but
it isn't fun...

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

