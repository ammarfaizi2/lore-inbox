Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282769AbRK0Dhm>; Mon, 26 Nov 2001 22:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282770AbRK0Dhe>; Mon, 26 Nov 2001 22:37:34 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:48306 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S282769AbRK0DhZ>;
	Mon, 26 Nov 2001 22:37:25 -0500
Message-ID: <3C030A73.8080506@candelatech.com>
Date: Mon, 26 Nov 2001 20:37:23 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, VLAN Mailing List <vlan@Scry.WANfear.com>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: [patch] 2.4.16: 802.1Q VLAN non-modular
In-Reply-To: <10181.1006827895@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, I just successfully compiled 2.4.16 (including VLAN
builtin) with no problems.  It looks like Maciej is compiling
MIPS, so it may be a bug particular to that platform??


Keith Owens wrote:

> On Mon, 26 Nov 2001 14:35:55 -0200 (BRST), 
> Rik van Riel <riel@conectiva.com.br> wrote:
> 
>>On Mon, 26 Nov 2001, Maciej W. Rozycki wrote:
>>
>>
>>> It appears the 802.1Q VLAN support didn't receive even basic testing,
>>>sigh...  It doesn't compile non-modular, due to vlan_proc_cleanup() being
>>>discarded, yet needed in vlan_proc_init().  Following is a fix.


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


