Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268730AbUILQvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268730AbUILQvU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 12:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbUILQvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 12:51:20 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:12184 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268730AbUILQvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 12:51:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4 - slowdown?
Date: Sun, 12 Sep 2004 18:52:36 +0200
User-Agent: KMail/1.6.2
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>, Andrew Morton <akpm@osdl.org>
References: <20040912161119.GR2260@mail.muni.cz>
In-Reply-To: <20040912161119.GR2260@mail.muni.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409121852.36844.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 of September 2004 18:11, Lukas Hejtmanek wrote:
> Hello,
> 
> I have fish-fillets game ported to linux. Under 2.6.9-rc1-bk9 it eats up to 
10%
> with normal speed of game and up to 40% with fast mode.
> Under 2.6.9-rc1-mm4 it eats up to 40% with normal speed of game and cpu is 
too
> slow for fast mode.
> 
> Any ideas?

Yup.  You've just discovered a difference between the nicksched and the 
"stock" CPU scheduler, it seems. ;-)

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
