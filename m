Return-Path: <linux-kernel-owner+w=401wt.eu-S1753552AbWL2EvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbWL2EvJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 23:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754546AbWL2EvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 23:51:08 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59703
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753552AbWL2EvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 23:51:07 -0500
Date: Thu, 28 Dec 2006 20:51:06 -0800 (PST)
Message-Id: <20061228.205106.130845178.davem@davemloft.net>
To: vonbrand@inf.utfsm.cl
Cc: bunk@stusta.de, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc2: known unfixed regressions 
From: David Miller <davem@davemloft.net>
In-Reply-To: <200612290136.kBT1a2sO006708@laptop13.inf.utfsm.cl>
References: <bunk@stusta.de>
	<200612290136.kBT1a2sO006708@laptop13.inf.utfsm.cl>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Thu, 28 Dec 2006 22:36:02 -0300

> Adrian Bunk <bunk@stusta.de> wrote:
> > This email lists some known regressions in 2.6.20-rc2 compared to 2.6.19.
> 
> Add that on SPARC64 boot fails due to missing /dev/root. Vanilla 2.6.19 and
> 2.6.19.1 work fine, before 2.6.20-rc1 it broke. I checked the initrds for
> both versions, the only difference "diff -Nur" finds between the unpacked
> initrds are the modules themselves (obviously).

Did you report this will all relevant details on sparclinux@vger
so that the sparc64 maintainers can analyze the problem?

I didn't see the report there else I would be looking into it.

Please don't report sparc64 bugs here, thanks.
