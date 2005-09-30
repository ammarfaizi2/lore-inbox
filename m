Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbVI3MLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbVI3MLc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 08:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbVI3MLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 08:11:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:10886 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030284AbVI3MLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 08:11:31 -0400
Subject: Re: BUG: 2.6.14-rc2 sets the wrong time in NVRAM on PowerMac G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Florin Iucha <florin@iucha.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050921130121.GB23362@iucha.net>
References: <20050921130121.GB23362@iucha.net>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 22:09:20 +1000
Message-Id: <1128082160.31197.42.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-21 at 08:01 -0500, Florin Iucha wrote:
> Hello,
> 
> At shutdown, kernel 2.6.14-rc2 saves the wrong value in the hardware
> clock, since at next bootup I get 21 August 1987.
> 
> I have narrowed the range down to:
>    2.6.14-rc1 is good
>    2.6.14-rc1-git1 is bad.
> 
> Also, the 2.6.14-rcX does not power off the machine at shutdown.
> 2.6.13 did work fine.

Is this still happening with current "git" ?

Ben.


