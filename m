Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVHUVPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVHUVPv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVHUVPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:15:51 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21194 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751109AbVHUVPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:15:50 -0400
Date: Sun, 21 Aug 2005 12:47:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: danial_thom@yahoo.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
Message-Id: <20050821124746.5d57203f.akpm@osdl.org>
In-Reply-To: <20050821154654.63788.qmail@web33303.mail.mud.yahoo.com>
References: <20050821154654.63788.qmail@web33303.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom <danial_thom@yahoo.com> wrote:
>
> I just started fiddling with 2.6.12, and there
> seems to be a big drop-off in performance from
> 2.4.x in terms of networking on a uniprocessor
> system. Just bridging packets through the
> machine, 2.6.12 starts dropping packets at
> ~100Kpps, whereas 2.4.x doesn't start dropping
> until over 350Kpps on the same hardware (2.0Ghz
> Opteron with e1000 driver). This is pitiful
> prformance for this hardware. I've 
> increased the rx ring in the e1000 driver to 512
> with little change (interrupt moderation is set
> to 8000 Ints/second). Has "tuning" for MP 
> destroyed UP performance altogether, or is there
> some tuning parameter that could make a 4-fold
> difference? All debugging is off and there are 
> no messages on the console or in the error logs.
> The kernel is the standard kernel.org dowload
> config with SMP turned off and the intel ethernet
> card drivers as modules without any other
> changes, which is exactly the config for my 2.4
> kernels.
> 

(added netdev to cc)
