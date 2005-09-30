Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVI3RMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVI3RMz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 13:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVI3RMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 13:12:55 -0400
Received: from ns1.coraid.com ([65.14.39.133]:41574 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1750790AbVI3RMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 13:12:54 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 2.6.14-rc2] aoe [1/3]: explicitly set minimum packet
 length to ETH_ZLEN
References: <87wtkzbz5z.fsf@coraid.com>
	<1128032491.9290.1.camel@localhost.localdomain>
	<874q83tsk9.fsf@coraid.com>
	<20050929.164545.109612016.davem@davemloft.net>
From: Ed L Cashin <ecashin@coraid.com>
Date: Fri, 30 Sep 2005 12:58:09 -0400
In-Reply-To: <20050929.164545.109612016.davem@davemloft.net> (David S.
 Miller's message of "Thu, 29 Sep 2005 16:45:45 -0700 (PDT)")
Message-ID: <87d5mqlcgu.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> writes:

> From: Ed L Cashin <ecashin@coraid.com>
> Date: Thu, 29 Sep 2005 18:31:02 -0400
>
>> We suspect that the e1000 driver is misbehaving when given short
>> packets, but we have not had time to pinpoint what part of the e1000
>> driver is involved or what the specific problem is.
>
> Then the e1000 driver is where the fix belongs, not the
> aoe driver.

OK, then I guess this one of the three patches can be dropped.

-- 
  Ed L Cashin <ecashin@coraid.com>

