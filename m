Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVCCDJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVCCDJH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVCCDFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 22:05:17 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:43664 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261449AbVCCDDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 22:03:20 -0500
Message-ID: <42267E75.200@candelatech.com>
Date: Wed, 02 Mar 2005 19:03:17 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>	<42264F6C.8030508@pobox.com>	<20050302162312.06e22e70.akpm@osdl.org>	<42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <42267737.4070702@pobox.com>
In-Reply-To: <42267737.4070702@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> I also note that part of the problem that motivates the even/odd thing 
> is a tacit acknowledgement that people only _really_ test the official 
> releases.
> 
> Which IMHO backs up my opinion that we simply need more frequent releases.

That doesn't really help in my opinion.  We need the comfort of knowing
that if we do find a bug, then soon we will have a release that will fix
this bug, with a *very* high probability of not changing anything else
significantly, or adding new regressions.  The current wait between
the official releases is too long to wait for a bug fix, but it is also likely
that other regressions have slipped in due to the large churn in the code.

If you simply release faster, without doing bug-fix only releases, then
I think we'll continue to see regressions.

I think the 2.6.X.y release scheme could work, as others have mentioned.


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

