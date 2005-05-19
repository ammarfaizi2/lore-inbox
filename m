Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVESRih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVESRih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 13:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVESRih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 13:38:37 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:31956 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261179AbVESRid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 13:38:33 -0400
Message-ID: <428CCE87.2010308@nortel.com>
Date: Thu, 19 May 2005 11:36:07 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Arjan van de Ven <arjan@infradead.org>, linux-os@analogic.com,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       "Gilbert, John" <JGG@dolby.com>, linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>	 <20050518195337.GX5112@stusta.de>	 <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>	 <20050519112840.GE5112@stusta.de>	 <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com> <1116505655.6027.45.camel@laptopd505.fenrus.org> <428CCD19.6030909@candelatech.com>
In-Reply-To: <428CCD19.6030909@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:

> It can be helpful to know what HZ you are running at, for instance if 
> you care
> very much about the (average) precision of a select/poll timeout.

If you move the binary to a different system (or upgrade the kernel, for 
that matter) the assumptions can be totally wrong.

This should be checked at runtime, not compile time.

Chris
